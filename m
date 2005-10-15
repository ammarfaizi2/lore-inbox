Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbVJOWBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbVJOWBN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 18:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbVJOWBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 18:01:13 -0400
Received: from ms004msg.fastwebnet.it ([213.140.2.58]:57218 "EHLO
	ms004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751242AbVJOWBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 18:01:13 -0400
Date: Sun, 16 Oct 2005 00:01:15 +0200
From: Mattia Dongili <malattia@linux.it>
To: emard@softhome.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: uinput crash and fix
Message-ID: <20051015220115.GG3564@inferi.kami.home>
Mail-Followup-To: emard@softhome.net, linux-kernel@vger.kernel.org
References: <20051015212911.GA25752@tink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051015212911.GA25752@tink>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.14-rc2-mm2-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2005 at 11:29:12PM +0200, emard@softhome.net wrote:
> HI
[...]
>  			req = uinput_request_find(udev, ff_up.request_id);
> -			if (!(req && req->code == UI_FF_UPLOAD && req->u.effect)) {
> +			if (!req) {

out of curiosity, instead of adding a whole if block wouldn't be easier
to just write 

	if (!req || !(req->code == UI_FF_UPLOAD && req->u.effect)) {

in order to evaulate !req first and eventually dereference it?
-- 
mattia
:wq!
