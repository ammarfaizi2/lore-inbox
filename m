Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422734AbWA1A1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422734AbWA1A1n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 19:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422736AbWA1A1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 19:27:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23315 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422734AbWA1A1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 19:27:42 -0500
Date: Sat, 28 Jan 2006 01:27:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>,
       David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths library
Message-ID: <20060128002741.GE3777@stusta.de>
References: <20060127092817.GB24362@infradead.org> <1138312694656@2gen.com> <1138312695665@2gen.com> <6403.1138392470@warthog.cambridge.redhat.com> <20060127204158.GA4754@hardeman.nu> <1138400385.8770.21.camel@lade.trondhjem.org> <8155F461-1703-476B-8C5D-B834EE49905D@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8155F461-1703-476B-8C5D-B834EE49905D@mac.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 06:35:40PM -0500, Kyle Moffett wrote:
> On Jan 27, 2006, at 17:19, Trond Myklebust wrote:
> >On Fri, 2006-01-27 at 21:41 +0100, David Härdeman wrote:
> >
> >>For example, a backup daemon which wishes to store the backup on  
> >>another host using ssh. Usually this is solved by storing an  
> >>unencrypted key in the fs or by providing a connection to a ssh- 
> >>agent which has been preloaded with the proper key(s). Both are  
> >>quite inelegant solutions.  With the in-kernel support, the daemon  
> >>can request the key using the request_key call, and (provided  
> >>proper scripts are written), the user who controls the relevant  
> >>key can supply it. This in turn means that the backup daemon can  
> >>sign using the key and read its public parts but not the private key.
> >
> >...but why would you want such a daemon to live in the kernel in  
> >the first place? A backup application might perhaps need some  
> >kernel support in order to ensure filesystem consistency, but that  
> >does not mean that moving the entire daemon into the kernel is a  
> >good idea.
> 
> No, the point is not to put the backup daemon into the kernel, but to  
> provide a way for the backup daemon and my user process to  
> communicate DSA key details without completely giving the backup  
> daemon my key.  I may not entirely trust the backup daemon not to get  
> compromised, but with support for the kernel keyring system,  
> compromising the backup daemon would only compromise the backed up  
> files, not the private keys and other secure data.

And why exactly is this not solvable through a userspace daemon?

> Cheers,
> Kyle Moffett

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

