Return-Path: <linux-kernel-owner+w=401wt.eu-S1754918AbWL1SRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918AbWL1SRj (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 13:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754919AbWL1SRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 13:17:39 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:46044 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754915AbWL1SRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 13:17:38 -0500
Date: Thu, 28 Dec 2006 19:17:36 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Benny Halevy <bhalevy@panasas.com>
Cc: Jeff Layton <jlayton@poochiereds.net>,
       Arjan van de Ven <arjan@infradead.org>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
Subject: Re: Finding hardlinks
In-Reply-To: <4593DEF8.5020609@panasas.com>
Message-ID: <Pine.LNX.4.64.0612281916230.2960@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz> 
 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>  <20061221185850.GA16807@delft.aura.cs.cmu.edu>
  <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
 <1166869106.3281.587.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
 <4593890C.8030207@panasas.com> <4593C524.8070209@poochiereds.net>
 <4593DEF8.5020609@panasas.com>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This sounds like a bug to me. It seems like we should have a one to one
>> correspondence of filehandle -> inode. In what situations would this not be the
>> case?
>
> Well, the NFS protocol allows that [see rfc1813, p. 21: "If two file handles from
> the same server are equal, they must refer to the same file, but if they are not
> equal, no conclusions can be drawn."]
>
> As an example, some file systems encode hint information into the filehandle
> and the hints may change over time, another example is encoding parent
> information into the filehandle and then handles representing hard links
> to the same file from different directories will differ.

BTW. how does (or how should?) NFS client deal with cache coherency if 
filehandles for the same file differ?

Mikulas
