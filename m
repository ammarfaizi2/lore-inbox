Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268469AbUHLJJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268469AbUHLJJN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 05:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268474AbUHLJJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 05:09:12 -0400
Received: from mail1.srv.poptel.org.uk ([213.55.4.13]:33177 "HELO
	mail1.srv.poptel.org.uk") by vger.kernel.org with SMTP
	id S268469AbUHLJJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 05:09:09 -0400
Message-ID: <411B3335.3030109@phonecoop.coop>
Date: Thu, 12 Aug 2004 10:07:01 +0100
From: Alan Jenkins <sourcejedi@phonecoop.coop>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: cd burning: kernel / userspace?
References: <41189AA2.3010908@phonecoop.coop> <20040810220528.GA17537@animx.eu.org> <4119DFB0.6050204@phonecoop.coop> <20040811164109.GA18761@animx.eu.org> <411A89BB.60505@phonecoop.coop> <20040811213322.GA19908@animx.eu.org> <411A92EC.6090609@phonecoop.coop> <20040812001218.GA20341@animx.eu.org>
In-Reply-To: <20040812001218.GA20341@animx.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:

>>Sorry, I'm not very good at this list / person CC stuff.  I sent a reply 
>>to Valdis.Kletnieks@vt.edu, but forgot to CC to list.  Contents as follows:
>>
>>I'm not sure this is necessary.  Can't you just do:
>>
>># dump -0 -B 700000 -u -z3 /home -f -| cdrecord /dev/hdb -
>>
>>dump and cdrecord allow you to use "-" as a filename to indicate that 
>>output shoud be written to stdout and input should be read from stdin 
>>respectively.
>>    
>>
>
>Yes, but if I was to understand it right, dump will close/reopen at "700000"
>(whatever that is, 700000kb?).  That won't work with cdrecord since it's
>expecting a single input stream, not many seperated by a pause.  I'd
>consider it more like using tar with the multiple tape option.  When it is
>finished writing to a tape, it'll wait for the user to physically change
>tapes and start writing at the beginning of the new tape.
>
>  
>
I get it now.  BTW, if dump can determine when the end of the media is 
reached it will close / reopen automatically, so it might also be 
possible to drop the -B option and make full use of media of different 
sizes (you can backup more data to an 80 minute CDR, less to a "business 
card" format one).  You couldn't do that with "playing double-buffering 
games using -F to switch around".
