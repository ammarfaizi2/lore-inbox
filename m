Return-Path: <linux-kernel-owner+w=401wt.eu-S932110AbXAFT2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbXAFT2S (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 14:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbXAFT2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 14:28:17 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:44440 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110AbXAFT2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 14:28:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QGaRUHNPdVvmW8wPU6opyOkjAURGxbhk89X0YtMnUFxLJrj7//wtK1dn2jPJ6HTrF0jIwe8ZQP6PB3YZkQFmT4eLim4a2+NLF1DrOHwXWnY/2+wdVK8OREMg/7XKNf2dgJP5JEbOIx5W0gHpZrhUQsEcQu+IsRrynUIV5ElyGMg=
Message-ID: <58cb370e0701061128t439b0a15w82063a8d23fe6c16@mail.gmail.com>
Date: Sat, 6 Jan 2007 20:28:15 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: "Kasper Sandberg" <lkml@metanurb.dk>
Subject: Re: libata error handling
Cc: "Robert Hancock" <hancockr@shaw.ca>,
       "LKML Mailinglist" <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       alan@lxorguk.ukuu.org.uk
In-Reply-To: <1168110512.1512.13.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <fa.pdj7pJD9C08bRZatFINV1hz1oyA@ifi.uio.no>
	 <459FE8BE.7070208@shaw.ca> <1168109874.1512.11.camel@localhost>
	 <459FF1F8.1050306@shaw.ca> <1168110512.1512.13.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/07, Kasper Sandberg <lkml@metanurb.dk> wrote:
> On Sat, 2007-01-06 at 13:01 -0600, Robert Hancock wrote:
> > Kasper Sandberg wrote:
> > > On Sat, 2007-01-06 at 12:21 -0600, Robert Hancock wrote:
> > >> Kasper Sandberg wrote:
> > >>> i have heard that libata has much better error handling (this is what
> > >>> made me try it), and from initial observations, that appears to be very
> > >>> true, however, im wondering, is there something i can do to get
> > >>> extremely verbose information from libata? for example if it corrects
> > >>> errors? cause i'd really like to know if it still happens, and if i
> > >>> perhaps get corruption as before, even though not severe.
> > >> Any errors, timeouts or retries would be showing up in dmesg..
> > > how sure can i be of this? is it 100% sure that i have not encountered
> > > this error then?
> >
> > Pretty sure, I'm quite certain libata never does any silent error recovery..

AFAIR this is true
(at least it was last time that I've looked at libata eh code)

> okay, i suppose i face two possibilities then:
> 1: libata drivers are simply better, and the error does not occur
> because of driver bugs in the old ide drivers

very likely however pdc202xx_new bugs should be fixed in 2.6.20-rc3
(as it contains a lot of bugfixes for this driver from Sergei Shtylyov)

> 2: it hasnt happened to me on libata yet (though this is also abit
> weird, as it has now ran far longer than were previously required to hit
> the errors)
