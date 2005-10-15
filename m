Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbVJOWs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbVJOWs1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 18:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVJOWs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 18:48:27 -0400
Received: from ms001msg.fastwebnet.it ([213.140.2.51]:48580 "EHLO
	ms001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751253AbVJOWs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 18:48:26 -0400
Date: Sun, 16 Oct 2005 00:48:23 +0200
From: Mattia Dongili <malattia@linux.it>
To: emard@softhome.net, linux-kernel@vger.kernel.org
Subject: Re: uinput crash and fix
Message-ID: <20051015224822.GH3564@inferi.kami.home>
Mail-Followup-To: emard@softhome.net, linux-kernel@vger.kernel.org
References: <20051015212911.GA25752@tink> <20051015220115.GG3564@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051015220115.GG3564@inferi.kami.home>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.14-rc2-mm2-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2005 at 12:01:15AM +0200, Mattia Dongili wrote:
> On Sat, Oct 15, 2005 at 11:29:12PM +0200, emard@softhome.net wrote:
> > HI
> [...]
> >  			req = uinput_request_find(udev, ff_up.request_id);
> > -			if (!(req && req->code == UI_FF_UPLOAD && req->u.effect)) {
> > +			if (!req) {
> 
> out of curiosity, instead of adding a whole if block wouldn't be easier
> to just write 
> 
> 	if (!req || !(req->code == UI_FF_UPLOAD && req->u.effect)) {
> 
> in order to evaulate !req first and eventually dereference it?

hmmm... no. it's simply the same ( (A && B) == (!A || !B)). So your
patch seems wrong too.

goodnight :P
-- 
mattia
:wq!
