Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263827AbUDVHoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263827AbUDVHoQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 03:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263825AbUDVHmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 03:42:40 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:20338 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263866AbUDVHlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:41:14 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 8/15] New set of input patches: atkbd - use bitfields
Date: Thu, 22 Apr 2004 02:41:11 -0500
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <200404210049.17139.dtor_core@ameritech.net> <200404210057.52989.dtor_core@ameritech.net> <20040422073113.GD340@ucw.cz>
In-Reply-To: <20040422073113.GD340@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404220241.11546.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 April 2004 02:31 am, Vojtech Pavlik wrote:
> On Wed, Apr 21, 2004 at 12:57:51AM -0500, Dmitry Torokhov wrote:
> > 
> > ===================================================================
> > 
> > 
> > ChangeSet@1.1909, 2004-04-20 22:29:12-05:00, dtor_core@ameritech.net
> >   Input: remove unneeded fields in atkbd structure, convert to bitfields
> 
> I think this is incorrect. We cannot set the bits in bitfields
> atomically, which we need in some cases. We probably need to add
> volatiles to some of them, too.
> 
> 

I don't think we have a problem with concurrent access here... One group is set
exclusively in atkbd_interrupt, other one is pretty mich static.

-- 
Dmitry
