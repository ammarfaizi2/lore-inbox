Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264251AbUHDKgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUHDKgA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 06:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUHDKft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 06:35:49 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:27277
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S264098AbUHDKfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 06:35:30 -0400
Message-ID: <4110BBEF.1040709@bio.ifi.lmu.de>
Date: Wed, 04 Aug 2004 12:35:27 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS-mounted, read-only /dev unusable in 2.6
References: <410F481C.9090408@bio.ifi.lmu.de>	<64bf.410f9d6f.62af@altium.nl>	<ceouv0$7s8$2@news.cistron.nl>	<41108380.6080809@bio.ifi.lmu.de>	<20040804064716.GA31600@traveler.cistron.net> <16656.35530.819884.579436@cse.unsw.edu.au>
In-Reply-To: <16656.35530.819884.579436@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:

>>But I just tried to reproduce this on 2.6.7-rc2 (it's what my
>>workstation happens to be running) and I can't. I can mount an
>>nfs-exported /dev from both 2.4 and 2.6 servers read-only and
>>I can open devices on that read-only mount just fine.
> 
> 
> Yes, it was a bug in the NFS server in 2.6 that was fixed fairly
> recently.

Hi Neil,

it still occurs in 2.6.8rc3 in some way:

Server and client both running 2.6.8rc3. The client mounts the /dev
directory from the server *read-only always*:

- when the server exports its /dev ro, the client cannot echo sth.
   to the mounted dev/console
- when the server exports its /dev rw, the client can echo to dev/console,
   although it has mounted it ro.

A client running kernel 2.4 can echo to dev/console in both cases,
even with the server exporting /dev ro.

So I'm not sure if this is a client or server issue, but I guess that
Trond is reading NFS stuff here, too...


cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
