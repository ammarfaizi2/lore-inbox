Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281155AbRKTQOF>; Tue, 20 Nov 2001 11:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281158AbRKTQNz>; Tue, 20 Nov 2001 11:13:55 -0500
Received: from schroeder.cs.wisc.edu ([128.105.6.11]:2825 "EHLO
	schroeder.cs.wisc.edu") by vger.kernel.org with ESMTP
	id <S281155AbRKTQNt>; Tue, 20 Nov 2001 11:13:49 -0500
Message-Id: <200111201613.fAKGDUt21490@schroeder.cs.wisc.edu>
Content-Type: text/plain; charset=US-ASCII
From: Nick LeRoy <nleroy@cs.wisc.edu>
Organization: UW Condor
To: wr6@uni.de, "J.A. Magallon" <jamagallon@able.es>,
        James A Sutherland <jas88@cam.ac.uk>
Subject: Re: Swap
Date: Tue, 20 Nov 2001 10:12:32 -0600
X-Mailer: KMail [version 1.3.1]
Cc: Remco Post <r.post@sara.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <200111191051.LAA04099@zhadum.sara.nl> <20011120155143.A4597@werewolf.able.es> <20011120160131.87644332@localhost.localdomain>
In-Reply-To: <20011120160131.87644332@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 November 2001 10:01, Wolfgang Rohdewald wrote:
> On Tuesday 20 November 2001 15:51, J.A. Magallon wrote:
> > When a page is deleted for one executable (because we can re-read it from
> > on-disk binary), it is discarded, not paged out.
>
> What happens if the on-disk binary has changed since loading the program?

In general, you can't...  You get a ETXTBSY 'text file busy' error.  If you 
try to do this over NFS (where the system can't stop you), the running image 
will almost certainly crash if it tries to page in text.

-Nick
