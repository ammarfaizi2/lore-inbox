Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316185AbSHIV4a>; Fri, 9 Aug 2002 17:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316199AbSHIV4a>; Fri, 9 Aug 2002 17:56:30 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:5472 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S316185AbSHIV43>; Fri, 9 Aug 2002 17:56:29 -0400
Date: Fri, 9 Aug 2002 17:00:12 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200208092200.RAA34736@tomcat.admin.navo.hpc.mil>
To: dezwart@froob.net,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: 2.4.19: drivers/usb/printer.c usblpX on fire
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete de Zwart <dezwart@froob.net>:
> 
> Around about 1010h 09/08/2002, Samuel Flory emitted the following wisdom:
> >   The printer on fire message is the traditional Un*x error message for
> > unknown error on a printer.
> 
> 	What I don't understand is why the misleading message is sent
> instead of the printer driver stating that it has received an unknown printer
> error code and printing the code number.
> 
> 	Out of curiosity, does there exist an error code that a printer can
> assert that specifies that it is "on fire"?

Ummm no.

As I understand it, this message is related to a parallel port (input only
style) status code - ready, online, check.

The "check" signal might have had a slightly different name, but it was
a "unknown error".

The fire message came from the old drum printers. These had the alphabet
on a 3 inch diameter steel drum, one ring of the alphabet for each colum.

Over this would run a ribbon, about 24 inches in width, and 10 feet long.
This assembly was all mounted on a door to give access to the paper, and
the print hammers.

The print hammers are all mounted on a fixed base of the printer body, with
the fanfold paper running over it.

The drum rotated about 1200 to 2400 RPM. Faster for higher speed printers.

What happens is that the ribbon gets worn and tends to slide toward the
side of the printer that is printed on the most (ribbon shrinks, and it
is the right side of the printer). When working normally, the ribbon moves
at about 1/4 the speed of the drum. Whenever the ribbon reached the end,
it would hit a switch that would reverse the direction of the ribbon feed.

When the ribbon started shrinking on the right, the entire roll would
start bunching up on the right, leaving the left side of the drum
rotating at high speed, directly against the paper.

This condition generates quite a bit of paper dust.

It also tends to cause the paper to jam. If the jam isn't detected soon
enough, the accumulated paper dust, ink dust, real paper, AND the rapidly
rotating drum would generate enough heat-by-friction contact to start
a fire.

This condition is made worse by the printer cleaning solution, which was
usually denatured alcohol, whose fumes tended to collect in the ribbon.
(had that start a fire once - somebody turned the printer on before the
 drum had dried; something sparked and there was a brief flash of flame)

The paper jam usually set off the "check" signal and the host
would stop sending data to the printer, and report some message to the
operator. Sometimes, the offline switch would also be triggered, which
(at least in the printer) would stop the drum from spinning. The offline
switch was actually triggered by a different condition. I think it was
when the paper was no longer in contact with an "out of paper" sensor.
If the offline switch wasn't triggered, the drum would continue spinning,
and continue adding more heat.

The old lpd on UNIX v 6/7 used the check signal to report a "printer on fire"
if the offline signal was NOT present. I believe it was the combination of
offline and check signal that was used to generate the "out of paper"
message.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
