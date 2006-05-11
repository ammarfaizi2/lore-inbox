Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751673AbWEKM7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbWEKM7k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 08:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbWEKM7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 08:59:40 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48520 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751671AbWEKM7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 08:59:40 -0400
Subject: Re: [PATCH -mm] updated idetape gcc 4.1 warning fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200605101810.k4AIAA8x006488@dwalker1.mvista.com>
References: <200605101810.k4AIAA8x006488@dwalker1.mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 11 May 2006 14:11:41 +0100
Message-Id: <1147353102.26130.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-05-10 at 11:10 -0700, Daniel Walker wrote:
> I added returns for failures .. I would hope that this doesn't break anything in
> userspace , but I'll confess that I have no way to determin that for certain . 
> 
> Hows that Alan?

You still need to walk the BHs I think. Also if an error occurs and some
data is successfully transferred the standards explicitly require you
return the amount of data successfully transferred if you report an
error.

