Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132834AbRDXQvt>; Tue, 24 Apr 2001 12:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132571AbRDXQvk>; Tue, 24 Apr 2001 12:51:40 -0400
Received: from [195.63.194.11] ([195.63.194.11]:36882 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S132852AbRDXQvX>; Tue, 24 Apr 2001 12:51:23 -0400
Message-ID: <3AE5AC3B.7D117951@evision-ventures.com>
Date: Tue, 24 Apr 2001 18:39:23 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Tim Jansen <tim@tjansen.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Device Registry (DevReg) Patch 0.2.0
In-Reply-To: <01042403082000.05529@cookie> <3AE54A24.C90067F6@evision-ventures.com> <01042413442601.00792@cookie>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Jansen wrote:
> 
> On Tuesday 24 April 2001 11:40, Martin Dalecki wrote:
> > Tim Jansen wrote:
> > > The Linux Device Registry (devreg) is a kernel patch that adds a device
> > > database in XML format to the /proc filesystem. It collects all
> > OH SHIT!!      ^^^
> > Why don't you just add postscript output to /proc?
> 
> XML wasn't my first choice. The 0.1.x versions used simple name/value pairs,
> I gave this up after trying to fit the complex USB
> configuration/interface/endpoint data into name/value pairs. Thinking about
> text file formats that allow me to display hierarchical information,  XML was
> the obvious choice for me. Are there alternatives to get complex and
> extendable information out to user space? (see
> http://www.tjansen.de/devreg/devreg.output.txt for a example /proc/devreg
> output)

Yes filesystem structures. Or just simple parsing in the user space
plain binary
data.

> My other ideas were:
> - using a simple binary format, just dump structs. This would break all
> applications every time somebody changes the format, and this should happen
> very often because of the nature of the format
> - using a complicated, extendable binary format, for example chunk-based like
> (a|r)iff file formats. This would add more code in the kernel than XML
> output, is difficult to understand and requires more work in user space
> (because XML parsers are already available)
> - making up a new text-based format with properties similar to XML because I
> knew that many people dont like the idea of XML output in the kernel.. I
> really thought about it, but it does not make much sense.
> 
> The actual code overhead of XML output compared to a format like
> /proc/bus/usb/devices is almost zero, XML is only a little bit more verbose.
> I agree that XML is not perfect for this kind of data, but it is simple to
> generate, well known and I dont see a better alternative.
> 
> bye..
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort:
ru_RU.KOI8-R
