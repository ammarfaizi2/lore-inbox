Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266085AbUA1SZm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 13:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266091AbUA1SZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 13:25:42 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:44506 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S266085AbUA1SZk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 13:25:40 -0500
Subject: Re: Cset 1.1490.4.201 - dasd naming
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: laroche@redhat.com, linux-kernel@vger.kernel.org, zaitcev@redhat.com
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OFB06159CB.9DAF0D86-ONC1256E29.006494C6-C1256E29.0065354B@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Wed, 28 Jan 2004 19:25:27 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 28/01/2004 19:25:30
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pete,

> Martin, it is your architecture to break as you wish, but my gut feeling
> is that you'd never get away with this if you did it on anything using
> common use peripherals. This is a return to times of UNIX v6 and /dev/rk1a.
> The chief penguin repeatedly stated that he wanted to see /dev/diskN
> or similar (defined by a userland policy).
The idea was to get rid of the dasdxyz names which are not intuitive.

> Considering Fedora Core 2, I do not know if we have time to repair the
> damage. For the moment, I am patching a reverse patch.
Ok.

> Is there a story of a real world deployment where the 2.4 scheme was
> a hindrance which you could share? Honestly, I'm surprised you bring
> the matter of "persistent names" instead of, say, exhaustion of
> address range and majors.
That is probably the main argument to go back to the old names. After
udev and friends are in place it is not important how the disk is named
internally. The only place where it would surface is on the root=
parameter.

I'll discuss this with the Horst again to see if we really need the
dasd_<busid>_ names or if we can live with the old style names on the
root= parameter.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com



