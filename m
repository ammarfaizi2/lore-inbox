Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263758AbTDDPnJ (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 10:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263781AbTDDPl7 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 10:41:59 -0500
Received: from cm19173.red.mundo-r.com ([213.60.19.173]:13872 "EHLO
	trasno.mitica") by vger.kernel.org with ESMTP id S263758AbTDDPg4 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 10:36:56 -0500
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] only use 48-bit lba when necessary
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20030404132214.GC786@suse.de> (Jens Axboe's message of "Fri, 4
 Apr 2003 15:22:14 +0200")
References: <20030404122936.GB786@suse.de> <86k7ea2ydy.fsf@trasno.mitica>
	<20030404132214.GC786@suse.de>
Date: Fri, 04 Apr 2003 17:48:20 +0200
Message-ID: <86wuia1cxn.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

jens> +	if (drive->addressing == 1 && block > 0xfffffff)
jens> +		lba48 = 1;
jens> +
>> 
>> lba48 = (drive->addressing == 1) && (block > 0xfffffff);
>> 
>> should do the trick.

jens> I'm not going to use such nonsense, sorry. The spelled out versions are
jens> a lot more readable. The command ?: constructs used in ide-disk are a
jens> joke, imo.

Read it again, please.  Told me wehre are the ?: command.

Reason is that:

if (expr)
   var = true;
else
   var = false;

is always a bad construct.

var = expr;

is a better construct to express that meaning.

And yes, your is a variation of the same theme:

var = false;
if (expr)
   var = true;

Later, Juan "who also didn't like ?: operator"



-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
