Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263823AbUDVHph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbUDVHph (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 03:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263825AbUDVHo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 03:44:28 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:8045 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263816AbUDVHn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:43:56 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 9/15] New set of input patches: atkbd timeout complaints
Date: Thu, 22 Apr 2004 02:43:53 -0500
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <200404210049.17139.dtor_core@ameritech.net> <200404210058.44629.dtor_core@ameritech.net> <20040422073230.GE340@ucw.cz>
In-Reply-To: <20040422073230.GE340@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404220243.53557.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 April 2004 02:32 am, Vojtech Pavlik wrote:
> On Wed, Apr 21, 2004 at 12:58:42AM -0500, Dmitry Torokhov wrote:
> > 
> > ===================================================================
> > 
> > 
> > ChangeSet@1.1910, 2004-04-20 22:32:46-05:00, dtor_core@ameritech.net
> >   Input: Do not generate events from atkbd until keyboard is completely
> >          initialized. It should suppress messages about suprious NAKs
> >          when controller's timeout is longer than one in atkbd
> 
> We may need to protect ourselves against this - it may confuse the probe
> in addition to just generating spurious messages.
>

Hmm.. you were against extending timeout in atkbd_command as it would prolong
probing. It should not interfere with probing as we only kill data when we not
expecting a response to a command.  

-- 
Dmitry
