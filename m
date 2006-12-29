Return-Path: <linux-kernel-owner+w=401wt.eu-S965058AbWL2KMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbWL2KMa (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 05:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbWL2KMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 05:12:30 -0500
Received: from pat.uio.no ([129.240.10.15]:51591 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965027AbWL2KM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 05:12:29 -0500
Subject: Re: Finding hardlinks
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Benny Halevy <bhalevy@panasas.com>
Cc: Jeff Layton <jlayton@poochiereds.net>,
       Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Arjan van de Ven <arjan@infradead.org>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
In-Reply-To: <4593DEF8.5020609@panasas.com>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
	 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>
	 <20061221185850.GA16807@delft.aura.cs.cmu.edu>
	 <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
	 <1166869106.3281.587.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
	 <4593890C.8030207@panasas.com> <4593C524.8070209@poochiereds.net>
	 <4593DEF8.5020609@panasas.com>
Content-Type: text/plain
Date: Fri, 29 Dec 2006 11:12:08 +0100
Message-Id: <1167387128.6106.32.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=failed, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: 290988B3949ACF5B314455C39589516D693E45C8
X-UiO-SPAM-Test: 83.109.147.16 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-28 at 17:12 +0200, Benny Halevy wrote:

> As an example, some file systems encode hint information into the filehandle
> and the hints may change over time, another example is encoding parent
> information into the filehandle and then handles representing hard links
> to the same file from different directories will differ.

Both these examples are bogus. Filehandle information should not change
over time (except in the special case of NFSv4 "volatile filehandles")
and they should definitely not encode parent directory information that
can change over time (think rename()!).

Cheers
  Trond

