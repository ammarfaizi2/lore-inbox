Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132416AbRDXQuj>; Tue, 24 Apr 2001 12:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132571AbRDXQu3>; Tue, 24 Apr 2001 12:50:29 -0400
Received: from www.topmail.de ([212.255.16.226]:38586 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S132416AbRDXQuS>;
	Tue, 24 Apr 2001 12:50:18 -0400
Message-ID: <03f201c0ccde$a3bde0f0$de00a8c0@homeip.net>
From: "mirabilos" <eccesys@topmail.de>
To: "Tim Jansen" <tim@tjansen.de>,
        "Martin Dalecki" <dalecki@evision-ventures.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <01042403082000.05529@cookie> <3AE54A24.C90067F6@evision-ventures.com> <01042413442601.00792@cookie>
Subject: Re: Device Registry (DevReg) Patch 0.2.0
Date: Tue, 24 Apr 2001 16:43:44 -0000
Organization: eccesys.net Linux development
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > The Linux Device Registry (devreg) is a kernel patch that adds a
device
> > > database in XML format to the /proc filesystem. It collects all
> > OH SHIT!!      ^^^
> > Why don't you just add postscript output to /proc?
>
> XML wasn't my first choice. The 0.1.x versions used simple name/value
pairs,
> I gave this up after trying to fit the complex USB
> configuration/interface/endpoint data into name/value pairs. Thinking
about
> text file formats that allow me to display hierarchical information,
XML was
> the obvious choice for me. Are there alternatives to get complex and
> extendable information out to user space? (see
> http://www.tjansen.de/devreg/devreg.output.txt for a example
/proc/devreg
> output)
> My other ideas were:
> - using a simple binary format, just dump structs. This would break
all
> applications every time somebody changes the format, and this should
happen
> very often because of the nature of the format
> - using a complicated, extendable binary format, for example
chunk-based like
> (a|r)iff file formats. This would add more code in the kernel than XML
> output, is difficult to understand and requires more work in user
space
> (because XML parsers are already available)
> - making up a new text-based format with properties similar to XML
because I
> knew that many people dont like the idea of XML output in the kernel..
I
> really thought about it, but it does not make much sense.

What about indenting? I think of 0 spaces before the device name,
1 space before properties which belong to the device. (Is one level
enough? I'm currently offline so didn't check the sample)
Structure per entry:
   [Space] Name colon property
It also could be an equality sign, but then we could use no
indention at all and [] for the sections, which leaves us
at .INI format, which after all still is lotta more readable after
cat than XML.

> The actual code overhead of XML output compared to a format like
> /proc/bus/usb/devices is almost zero, XML is only a little bit more
verbose.
> I agree that XML is not perfect for this kind of data, but it is
simple to
> generate, well known and I dont see a better alternative.
>
> bye..

-mirabilos


