Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269041AbRIDU6x>; Tue, 4 Sep 2001 16:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269223AbRIDU6o>; Tue, 4 Sep 2001 16:58:44 -0400
Received: from postfix2-2.free.fr ([213.228.0.140]:7432 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S269041AbRIDU62> convert rfc822-to-8bit; Tue, 4 Sep 2001 16:58:28 -0400
Date: Tue, 4 Sep 2001 22:55:52 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Jason Howard <jason@spectsoft.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: AMD 760 PCI Problem
In-Reply-To: <3B95348E.F8AE6E08@spectsoft.com>
Message-ID: <20010904224658.Y2154-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Sep 2001, Jason Howard wrote:

> Hello All,
>
> I am having trouble getting decent PCI throughput on either of my AMD
> system (both using the AMD 760 chipset.)  I am moving a high definition
> frame into a pci frame buffer.  This process takes somewhere around 100
> ms on my Dual Xeon system, however on the two AMD systems I have tried
> it is taking about 1 sec (1000 ms).
>
> The two systems I have tried are a single processor athlon system and a
> dual processor athlon system.  (Both use the AMD chipset .. the single
> uses the AMD760 and the dual uses the AMD760MP).  Both boxes are running
> kernel 2.4.6.
>
> Any suggestions?

Check the settings of the MTRR's against the frame buffer window.

If they appear not to be configured correctly, you just have to ask the
kernel to fix the thing (a MTRR defined for Write Combining must contain
the address range of the frame buffer).

see: linux/Documentation/mtrr.txt by Richard Gooch for details.

  Gérard.

