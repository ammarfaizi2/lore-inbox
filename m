Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262699AbVEAVdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbVEAVdo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 17:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbVEAVcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 17:32:47 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:49613 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262707AbVEAVVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 17:21:48 -0400
Subject: Re: [linux-usb-devel] init 1 kill khubd on 2.6.11
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L0.0505011659130.19155-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0505011659130.19155-100000@netrider.rowland.org>
Content-Type: text/plain
Date: Sun, 01 May 2005 17:21:41 -0400
Message-Id: <1114982502.23614.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-01 at 17:01 -0400, Alan Stern wrote:
> On Sun, 1 May 2005, Andrey Borzenkov wrote:
> 
> > Hub driver is using SIGKILL to terminate khubd. Unfortunately on a number of 
> > distributions switching init levels implicitly does "killall -9", killing 
> > khubd. The only way to restart it is to reload USB subsystem.
> > 
> > Is signal usage in this case really needed? What about replacing it with 
> > simple flag (i.e. will patch be accepted)?
> 
> IMO the problem lies in those distributions.  They should not
> indiscrimately kill processes when switching init levels.

It's probably not indiscriminate, all the init scripts I have seen only
resort to kill -9 if the process fails to terminate in an orderly
fashion via the /etc/rcX.d/Kfoo script.

