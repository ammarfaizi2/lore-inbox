Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129043AbQKFO5b>; Mon, 6 Nov 2000 09:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129061AbQKFO5V>; Mon, 6 Nov 2000 09:57:21 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:37135 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129043AbQKFO5N>; Mon, 6 Nov 2000 09:57:13 -0500
Date: Mon, 6 Nov 2000 15:57:02 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Catalin BOIE <util@deuroconsult.ro>
Cc: linux-kernel@vger.kernel.org, linux-admin@vger.kernel.org
Subject: Re: Kernel hook for open
Message-ID: <20001106155702.F12348@arthur.ubicom.tudelft.nl>
In-Reply-To: <Pine.LNX.4.20.0011061547590.1080-100000@marte.Deuroconsult.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.20.0011061547590.1080-100000@marte.Deuroconsult.ro>; from util@deuroconsult.ro on Mon, Nov 06, 2000 at 03:55:41PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
X-Loop: erik@arthur.ubicom.tudelft.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2000 at 03:55:41PM +0200, Catalin BOIE wrote:
> I wish to know if there is something like a kernel hook for open function.
> I want to monitor a file (someting like watchdog on Solaris) and to read
> from my own process (module?) and from the file.

I don't know what watchdog is, but maybe strace is what you want (man
strace for more info).

> I tried with LD_SO_PRELOAD but it haven't any effect on the so libraries.
> For example:
> If I use function getpwent (that is in a so library) and my home
> made .so library that overwrite "open" function and is in
> /etc/ld.so.preload file it doesn't work.
> Of course, if I use open ("/etc/hosts") the so library execute my
> function. 

Use LD_PRELOAD instead.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
