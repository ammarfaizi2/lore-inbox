Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132372AbQLQF6a>; Sun, 17 Dec 2000 00:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132403AbQLQF6V>; Sun, 17 Dec 2000 00:58:21 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:47876 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S132372AbQLQF6P>;
	Sun, 17 Dec 2000 00:58:15 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200012170527.eBH5Rbr441809@saturn.cs.uml.edu>
Subject: Re: 2.2.18 signal.h
To: meissner@spectacle-pond.org (Michael Meissner)
Date: Sun, 17 Dec 2000 00:27:37 -0500 (EST)
Cc: andrea@suse.de (Andrea Arcangeli),
        Franz.Sirl-kernel@lauterbach.com (Franz Sirl),
        root@chaos.analogic.com (Richard B. Johnson),
        mblack@csihq.com (Mike Black),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.or)
In-Reply-To: <20001215153130.B24830@munchkin.spectacle-pond.org> from "Michael Meissner" at Dec 15, 2000 03:31:30 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Meissner writes:
> On Fri, Dec 15, 2000 at 07:54:33PM +0100, Andrea Arcangeli wrote:
>> On Fri, Dec 15, 2000 at 06:59:24PM +0100, Franz Sirl wrote:

>>> It's required by ISO C, and since that's the standard now, gcc
>>> spits out a  warning. Just adding a ; is enough and already
>>> done for most stuff in 2.4.0-test12.
...
>> Why am I required to put a `;' only in the last case and not in
>> all the previous ones? Or maybe gcc-latest is forgetting to
>> complain about the previous ones ;)
>
> Because neither
> 
> 	<label>:		(nor)
> 	case <expr>:		(nor)
> 	default:
> 
> are statements by themselves.

For the GNU C language they are. For the ISO C language they are not.
If there had been a flag such as -ansi or -std=iso-me-harder then
the warning would be appropriate. Without such a flag, gcc should
shut up and compile the code.

So this is a gcc language standard selection bug.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
