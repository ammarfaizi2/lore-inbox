Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129545AbQLEQJp>; Tue, 5 Dec 2000 11:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129538AbQLEQJZ>; Tue, 5 Dec 2000 11:09:25 -0500
Received: from columba.EUR.3Com.COM ([161.71.169.13]:59376 "EHLO
	columba.eur.3com.com") by vger.kernel.org with ESMTP
	id <S129535AbQLEQJX>; Tue, 5 Dec 2000 11:09:23 -0500
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: Steve Hill <steve@navaho.co.uk>
cc: PaulJakma <paulj@itg.ie>, linux-kernel@vger.kernel.org
Message-ID: <802569AC.0054D7AC.00@notesmta.eur.3com.com>
Date: Tue, 5 Dec 2000 15:20:28 +0000
Subject: Re: Serial Console
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>>
>> /dev/console will go to serial, but afaik it doesn't block for lack of
>> a terminal. (has something to do with /dev/console being semantically
>> different to /dev/tty..., eg it doesn't block, not sure of the exact
>> details).

>Nope, /dev/console *does* block.  ATM I've found a quick workaround - I
>use "stty -F /dev/console clocal -crtscts" to turn off the serial flow
>control at the stawrt of /etc/rc.d/rc.sysinit - this seems to work quite
>well... of course it doesn't stop some program turning flow control back
>on and ballsing it all up again :)

I've got a machine here which redirects the console to the serial port using
Lilo 'append="console=ttyS0"' and it boots fine without a connection to the
serial port without having to do any specific manipulation of the flow control.
I think that all serial output is dumped to /dev/null if DCD is not asserted no
matter what the flow control says. Perhaps there are some hardware differences
in the configuration of the control signal pull-up/downs.

     Jon Burgess




PLANET PROJECT will connect millions of people worldwide through the combined
technology of 3Com and the Internet. Find out more and register now at
http://www.planetproject.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
