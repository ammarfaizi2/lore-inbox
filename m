Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272370AbRH3Rut>; Thu, 30 Aug 2001 13:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272372AbRH3Ruk>; Thu, 30 Aug 2001 13:50:40 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:64521 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S272370AbRH3Ru2>; Thu, 30 Aug 2001 13:50:28 -0400
Date: Thu, 30 Aug 2001 19:50:41 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Tester <tester@videotron.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bizzare crashes on IBM Thinkpad A22e
Message-ID: <20010830195041.N1146@arthur.ubicom.tudelft.nl>
In-Reply-To: <Pine.LNX.4.33.0108301139310.8245-100000@TesterTop.PolyDom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0108301139310.8245-100000@TesterTop.PolyDom>; from tester@videotron.ca on Thu, Aug 30, 2001 at 11:46:19AM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2001 at 11:46:19AM -0400, Tester wrote:
> I've just received an IBM Thinkpad A22e. Using kernel 2.4.2-2 (redhat 7.1
> version) or the stock 2.4.4 or 2.4.9 (they all exhibit the same problem).

Uh-oh, another broken Thinkpad BIOS.

> When I use any of the APM functions or any of the thinkpad keys (volume
> keys and Fn-Fx keys.. for suspend and even display brightness), the whole
> system freezes without any other indication. This is using a kernel with
> APM compiled it, but without any other option. If I compile in ACPI
> instead of APM, it freezes even before the kernel is done booting. But, it
> worked perfectly well with the 2.2.19-2 kernel form Mandrake 7.2

Hmm, linux-2.2.19pre4 got the "thinkpad E820 edx overwriting" for a
Thinkpad 600X from Marc Joosen. The same fix also went into
2.4.0-test13-pre6, so that can't be the problem.

> Everything else seems to work fine... can anyone help?

Could you try to boot with "mem=one MB less than the machine actually
has" and see if that fixes the problem? So "mem=127M" for a 128MB
machine. If that fixes the problem, I think there is a bug in the e820
BIOS memory map and you should ask IBM to fix their BIOS.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
