Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265552AbUEZMgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265552AbUEZMgp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 08:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265553AbUEZMgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 08:36:44 -0400
Received: from mail45.messagelabs.com ([140.174.2.179]:60084 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S265552AbUEZMfU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 08:35:20 -0400
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-8.tower-45.messagelabs.com!1085574917!3170895
X-StarScan-Version: 5.2.11; banners=-,-,-
X-Originating-IP: [141.156.156.57]
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: why swap at all?
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Wed, 26 May 2004 08:34:52 -0400
Message-ID: <5D3C2276FD64424297729EB733ED1F7606100709@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: why swap at all?
Thread-Index: AcRDHTjZnMjAj93lRUiDN1SdBoGaCgAAI9Bg
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: <linux-kernel@vger.kernel.org>
Cc: <ap@solarrain.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If one has 16GB of ram, would he or she want to use swap?
Would it slow the system down?


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Matthias
Schniedermeyer
Sent: Wednesday, May 26, 2004 8:27 AM
To: Nick Piggin
Cc: linux-kernel@vger.kernel.org
Subject: Re: why swap at all?

On Wed, May 26, 2004 at 09:19:40PM +1000, Nick Piggin wrote:
> Matthias Schniedermeyer wrote:
> >On Wed, May 26, 2004 at 08:33:28PM +1000, Nick Piggin wrote:
> >
> >>Matthias Schniedermeyer wrote:
> >>
> 
> >>>In my personal machine i have 3GB of RAM and i regularly create
> >>>DVD-ISO-Images (about 2 per day). After creating an image (reading
up to
> >>>4,4GB and writing up to 4,4GB) the cache is 100% trashed(1). With
swap
> >>>it would be even more trashed then it is without swap(1).
> >>>
> >>
> >>I don't disagree that you could find a situation where swap
> >>is worse than no swap. I don't understand what you mean by
> >>trashed and more trashed though :)
> >
> >
> >trashed means "everything i need(tm)" is paged out
(mozilla/konsole/xine
> >...)
> >
> >with swap the data-part of running programs was swapped out, without
> >swap only the program-part is thrown out of memory as the data-part
> >can't be moved anywhere else.
> >
> >I have a 10KPRM SCSI-HDD, i can here what my system is doing. :-)
> >
> 
> OK, this is obviously bad. Do you get this behaviour with 2.6.5
> or 2.6.6? If so, can you strace the program while it is writing
> an ISO? (just send 20 lines or so). Or tell me what program you
> use to create them and how to create one?

program: mkisofs
kernel: 2.4.4-2.4.25, 2.6.4-2.6.6
(To say it in other words, i never (seen/felt) a difference in 3 years.
So if there is a difference i just didn't realized there is one)
The current kernel is 2.6.5 as 2.6.6 sometimes just "hangs"

Just throw together some lage files (My files are all >= 350MB, the
"typical" case is about 4-5files with 800-1000MB each) and then
mkisofs -J -r -o <image> <source-dir>
I store the image files on another HDD to get best possibel throughput.
My HDDs (these are "normal" IDE-HDDs) are capable of delivering about
35-40MB/s, the last time i measured i got about 70MB/s aggregated
throughput while creating an image-file.



Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


