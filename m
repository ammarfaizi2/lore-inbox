Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbTI3MdE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 08:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbTI3MdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 08:33:04 -0400
Received: from ns.suse.de ([195.135.220.2]:25028 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261426AbTI3Mc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 08:32:59 -0400
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Rogier Wolff <Swen-Trap1@BitWizard.nl>,
       Artur Klauser <Artur.Klauser@computer.org>,
       linux-kernel@vger.kernel.org
Subject: Re: div64.h:do_div() bug
References: <Pine.LNX.4.51.0309291503030.7947@enm.xynhfre.bet>
	<20030930095229.GA32421@bitwizard.nl>
	<20030930101438.GJ1058@mea-ext.zmailer.org>
	<20030930112830.GK1058@mea-ext.zmailer.org>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I am a jelly donut.  I am a jelly donut.
Date: Tue, 30 Sep 2003 14:30:40 +0200
In-Reply-To: <20030930112830.GK1058@mea-ext.zmailer.org> (Matti Aarnio's
 message of "Tue, 30 Sep 2003 14:28:30 +0300")
Message-ID: <je8yo6e9vz.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio <matti.aarnio@zmailer.org> writes:

> On Tue, Sep 30, 2003 at 01:14:38PM +0300, Matti Aarnio wrote:
>> On Tue, Sep 30, 2003 at 11:52:29AM +0200, Rogier Wolff wrote:
>> > On Mon, Sep 29, 2003 at 03:25:19PM +0200, Artur Klauser wrote:
>> > > I've found that a bug in asm-arm/div64.h:do_div() is preventing correct
>> > > conversion of timestamps in smbfs (and probably ntfs as well) from NT to
>> > 
>> > Nope. 
>> 
>>   Nope yourself.
>> 
>> > >   if (in.n64 != out.n64) {
>> > >     printf("FAILURE: asm/div64.h:do_div() is broken for 64-bit dividends\n");
>> > 
>> > do_div should be/is documented as not doing 64 bit dividents. It does
>> > 64/32 -> 32 divides, IIRC... 
>> 
>>   64/32 -> 64,32
>> 
>> The REMAINDER is 32 bit value.
>
> Non-native english speaker makes the mistake..  MODULUS is 32 bits as is
> DIVISOR, REMAINDER is 64 bit, as is DIVIDEND.
>
> That is:
> 	DIVIDEND / DIVISOR -> REMAINDER , MODULUS
                              ^^^^^^^^^^^^^^^^^^^
???
                              QUOTIENT, REMAINDER

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
