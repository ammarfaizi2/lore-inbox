Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264908AbSJ3Uup>; Wed, 30 Oct 2002 15:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264911AbSJ3Uup>; Wed, 30 Oct 2002 15:50:45 -0500
Received: from gate.in-addr.de ([212.8.193.158]:35344 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S264908AbSJ3Uun>;
	Wed, 30 Oct 2002 15:50:43 -0500
Date: Wed, 30 Oct 2002 21:56:52 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: "Matthew J. Fanto" <mattf@mattjf.com>, linux-kernel@vger.kernel.org
Subject: Re: The Ext3sj Filesystem
Message-ID: <20021030205652.GC22178@marowsky-bree.de>
References: <200210301434.17901.mattf@mattjf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200210301434.17901.mattf@mattjf.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-10-30T14:34:17,
   "Matthew J. Fanto" <mattf@mattjf.com> said:

> Encryption/decryption is transparent to the user, so the only thing 
> they will need to know is their key, and how to mount a device. We do not 
> encrypt the entire volume under the same key as some solutions do (this can 
> not only aid in a known-plaintext attack, but it gives the users less 
> options). Instead, every file is encrypted seperately under the key of the 
> users choice.

Do you encrypt before the data has hit the data journal or after? Does that
work for mmap etc?

> We are also adding support for reading keys off floppies, 
> cdroms, and USB keychain drives. Currently, ext3sj supports the following 
> algorithms: AES, 3DES, Twofish, Serpent, RC6, RC5, RC2, Blowfish, CAST-256, 
> XTea, Safer+, SHA1, SHA256, SHA384, SHA512, MD5, with more to come. 

This sounds like something you might want to abstract into a generic
architecture to be shared with the loop device code, or anything which might
need encryption in the kernel. Otherwise it is a PITA to maintain.

And I thought some of those algorithms were strictly signature / hash
algorithms, but you never stop learning ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Principal Squirrel 
SuSE Labs - Research & Development, SuSE Linux AG
  
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur
