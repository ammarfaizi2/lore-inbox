Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVBQW6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVBQW6x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 17:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVBQW6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 17:58:52 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:7952 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261220AbVBQW4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 17:56:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ZXK8MF6bGOR0nkWq2XBKUzZwqMCGvgdhgKYX0j10PFfvjc95TwF/0tuEYKOFNSXIUTmvvES/2S7dq+hzNo8W7W4QHDsheNGWi7i7t03EG07Y1pdr19C2o9cv4CuysFt7EW/kIZh7RgCySp89/tSWbkBPwuummWFbz0eicLYXl+o=
Message-ID: <9e473391050217145620fecfdc@mail.gmail.com>
Date: Thu, 17 Feb 2005 17:56:03 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
Cc: Jesse Barnes <jbarnes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1108680350.5665.7.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200502151557.06049.jbarnes@sgi.com>
	 <1108515817.13375.63.camel@gaston>
	 <200502161554.02110.jbarnes@sgi.com> <1108601294.5426.1.camel@gaston>
	 <9e473391050217083312685e44@mail.gmail.com>
	 <1108680350.5665.7.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2005 09:45:50 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

> Can't the size be obtained like any other BAR ?

yes, but cards that don't fully decode their ROM address space can
waste memory in copy_rom. For example I have a card around here that
reports a BAR address space of 128K and has a 2K ROM in it. You only
want to copy the 2K, not the 128K.


-- 
Jon Smirl
jonsmirl@gmail.com
