Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbVKKXIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbVKKXIl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 18:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbVKKXIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 18:08:41 -0500
Received: from maggie.cs.pitt.edu ([130.49.220.148]:30853 "EHLO
	maggie.cs.pitt.edu") by vger.kernel.org with ESMTP id S1751373AbVKKXIj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 18:08:39 -0500
From: Claudio Scordino <cloud.of.andor@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] getrusage sucks
Date: Sat, 12 Nov 2005 00:08:28 +0100
User-Agent: KMail/1.8
Cc: "Magnus Naeslund(f)" <mag@fbab.net>,
       "Hua Zhong (hzhong)" <hzhong@cisco.com>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org, David Wagner <daw@cs.berkeley.edu>
References: <75D9B5F4E50C8B4BB27622BD06C2B82BCF2FD4@xmb-sjc-235.amer.cisco.com> <200511112338.20684.cloud.of.andor@gmail.com> <1131751433.3174.50.camel@localhost.localdomain>
In-Reply-To: <1131751433.3174.50.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511120008.30157.cloud.of.andor@gmail.com>
X-Spam-Score: -1.665/8 BAYES_00 SA-version=3.000002
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 November 2005 00:23, Alan Cox wrote:
> On Gwe, 2005-11-11 at 23:38 +0100, Claudio Scordino wrote:
> > +                if ((current->euid != tsk->euid) &&
> > +                (current->euid != tsk->uid)) {
> > +                        read_unlock(&tasklist_lock);
> > +                        return -EINVAL;
>
> Would be -EPERM also wants a 'privilege' check. Not sure which would be
> best here - CAP_SYS_ADMIN seems to be the 'default' used

I would say -EPERM. Any other comment about the patch ?
