Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313237AbSDDQVC>; Thu, 4 Apr 2002 11:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313240AbSDDQUx>; Thu, 4 Apr 2002 11:20:53 -0500
Received: from [198.17.35.35] ([198.17.35.35]:35807 "HELO mx1.peregrine.com")
	by vger.kernel.org with SMTP id <S313237AbSDDQUh>;
	Thu, 4 Apr 2002 11:20:37 -0500
Message-ID: <B51F07F0080AD511AC4A0002A52CAB445B2D9A@OTTONEXC1>
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: "'Christoph Hellwig'" <hch@infradead.org>, Alfonso Gazo <agazo@unex.es>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [2.4.18] /proc/stat does not show disk_io stats for all IDE d
	isks
Date: Thu, 4 Apr 2002 08:20:24 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you please tru 2.4.18-ac/2.4.19-ac?

the SARD stuff from Alan's tree fixes this (in /proc/partitions though, but
that's ok)

the problem is that /proc/stat only checks major/minor combinations for
majors 0-16 and minors 0-16.  so if you have, say, hdc on major 22 then
it won't show up in /proc/stat.  Basically it's just done wrong :)

SARD fixes this by tracking all the relevant disk info properly, but it's
not in the mainline kernel :(

Dana Lacoste
Ottawa, Canada
