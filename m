Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316513AbSEOWmz>; Wed, 15 May 2002 18:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSEOWmx>; Wed, 15 May 2002 18:42:53 -0400
Received: from gate.in-addr.de ([212.8.193.158]:12293 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S316513AbSEOWmt>;
	Wed, 15 May 2002 18:42:49 -0400
Date: Thu, 16 May 2002 00:41:38 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Russell Leighton <russ@elegant-software.com>, Tony.P.Lee@nokia.com
Cc: wookie@osdl.org, alan@lxorguk.ukuu.org.uk, woody@co.intel.com,
        linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: InfiniBand BOF @ LSM - topics of interest
Message-ID: <20020515224138.GJ27307@marowsky-bree.de>
In-Reply-To: <4D7B558499107545BB45044C63822DDE3A2071@mvebe001.NOE.Nokia.com> <3CE2D4DB.3020702@elegant-software.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.99i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-05-15T17:36:27,
   Russell Leighton <russ@elegant-software.com> said:

> Lot's of very cool ideas for IB ...not knowing much about IB, but
> being curious and interested, I have a question which may be stupid
> so I apoligize in advance if it is...
> 
> Can we really have these sort of low level IB interactions and have :
>    - security issues addressed, mostly an issue if the devices are over 
> a network w/other devices

The idea is that the IB interconnect is "trusted". Doing very low level kernel
operations cluster-style over a non-trusted link is asking for it; either you
lose security-wise or performance for authentication / encryption _will_ kill
you.

The real interesting question from my side is "availability"; how does the
kernel deal with crashed nodes, loss of link etc? If you already had agreed or
semi-standard interfaces here, we would gladly pick them up.

These generic cluster interfaces are being discussed as part of the Open
Clustering Framework now, and it would be good if a kernel developer reviewed
the discussions regarding the generic event mechanism proposed from a kernel
perspective.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

