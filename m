Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318850AbSICQRo>; Tue, 3 Sep 2002 12:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318851AbSICQRn>; Tue, 3 Sep 2002 12:17:43 -0400
Received: from gate.in-addr.de ([212.8.193.158]:3082 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S318850AbSICQRm>;
	Tue, 3 Sep 2002 12:17:42 -0400
Date: Tue, 3 Sep 2002 18:23:02 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mount flag "direct"
Message-ID: <20020903162302.GD2344@marowsky-bree.de>
References: <Pine.SOL.3.96.1020903163309.14707D-100000@libra.cus.cam.ac.uk> <200209031544.g83FiAG03134@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200209031544.g83FiAG03134@oboe.it.uc3m.es>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-09-03T17:44:10,
   "Peter T. Breuer" <ptb@it.uc3m.es> said:

> No! I do not want /A/ fs, but /any/ fs, and I want to add the vfs
> support necessary :-).
> 
> That's really what my question is driving at. I see that I need to
> make VFS ops communicate "tag requests" to the block layer, in
> order to implement locking. Now you and Rik have pointed out one
> operation that needs locking. My next question is obviously: can you
> point me more or less precisely at this operation in the VFS layer?
> I've only started studying it and I am relatively unfamiliar with it.

Your approach is not feasible.

Distributed filesystems have a lot of subtle pitfalls - locking, cache
coherency, journal replay to name a few - which you can hardly solve at the
VFS layer.

Good reading would be any sort of entry literature on clustering, I would
recommend "In search of clusters" and many of the whitepapers Google will turn
up for you, as well as the OpenGFS source.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

