Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262832AbVCPWTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262832AbVCPWTc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 17:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbVCPWTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 17:19:32 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:37866 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262832AbVCPWT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 17:19:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=XdVwI9elPywcq1TAxHXOT5vLRe8O5A9IImP8AVto/GQSilimamAuoQqfaxII5j+GzRjH8f/2Hecgn0Bw4DgviDuBWJdU0FtXoQiAOAXE2Daahxz0LLr2A+gMKy6rnWDpdZ5RtuNQPWgKK1qt3a/6md57k0FArzuNYgy5SzFBDn4=
Message-ID: <d120d50005031614194a3bc41a@mail.gmail.com>
Date: Wed, 16 Mar 2005 17:19:29 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: linux-os@analogic.com
Subject: Re: Locking changes to the driver-model core
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <Pine.LNX.4.61.0503161602530.6525@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.44L0.0503161422440.639-100000@ida.rowland.org>
	 <Pine.LNX.4.61.0503161602530.6525@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2005 16:10:11 -0500 (EST), linux-os
<linux-os@analogic.com> wrote:
> 
> Thought experiment:
> Suppose you had a kernel-thread whos duty it was to handle the
> shutdown and restarting of devices on such busses. Since it
> is the only thing that would touch such code, wouldn't things
> be a lot simpler and not subject to deadlocks?
> 

You'd still have to mind devices that were added/removed from
probe/remove handlers while walking lists.

-- 
Dmitry
