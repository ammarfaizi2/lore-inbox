Return-Path: <linux-kernel-owner+w=401wt.eu-S1751115AbXADKOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbXADKOw (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 05:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbXADKOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 05:14:51 -0500
Received: from gw-e.panasas.com ([65.194.124.178]:38334 "EHLO
	cassoulet.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751098AbXADKOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 05:14:50 -0500
Message-ID: <459CD11E.3000200@panasas.com>
Date: Thu, 04 Jan 2007 12:04:14 +0200
From: Benny Halevy <bhalevy@panasas.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, nfsv4@ietf.org,
       linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@poochiereds.net>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [nfsv4] RE: Finding hardlinks
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>	 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>	 <20061221185850.GA16807@delft.aura.cs.cmu.edu>	 <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>	 <1166869106.3281.587.camel@laptopd505.fenrus.org>	 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>	 <4593890C.8030207@panasas.com> <4593C524.8070209@poochiereds.net>	 <4593DEF8.5020609@panasas.com>	 <Pine.LNX.4.64.0612281916230.2960@artax.karlin.mff.cuni.cz>	 <E472128B1EB43941B4E7FB268020C89B149CEC@riverside.int.panasas.com>	 <1167388129.6106.45.camel@lade.trondhjem.org>	 <E472128B1EB43941B4E7FB268020C89B149CF1@riverside.int.panasas.com>	 <1167780097.6090.104.camel@lade.trondhjem.org>	 <459BA30A.4020809@panasas.com> <1167899796.6046.11.camel@lade.trondhjem.org>
In-Reply-To: <1167899796.6046.11.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jan 2007 10:03:53.0828 (UTC) FILETIME=[A3F8A240:01C72FE7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trond Myklebust wrote:
> On Wed, 2007-01-03 at 14:35 +0200, Benny Halevy wrote:
>> I sincerely expect you or anybody else for this matter to try to provide
>> feedback and object to the protocol specification in case they disagree
>> with it (or think it's ambiguous or self contradicting) rather than ignoring
>> it and implementing something else. I think we're shooting ourselves in the
>> foot when doing so and it is in our common interest to strive to reach a
>> realistic standard we can all comply with and interoperate with each other.
> 
> You are reading the protocol wrong in this case.

Obviously we interpret it differently and that by itself calls for considering
clarification of the text :)

> 
> While the protocol does allow the server to implement the behaviour that
> you've been advocating, it in no way mandates it. Nor does it mandate
> that the client should gather files with the same (fsid,fileid) and
> cache them together. Those are issues to do with _implementation_, and
> are thus beyond the scope of the IETF.
> 
> In our case, the client will ignore the unique_handles attribute. It
> will use filehandles as our inode cache identifier. It will not jump
> through hoops to provide caching semantics that go beyond close-to-open
> for servers that set unique_handles to "false".

I agree that the way the client implements its cache is out of the protocol
scope. But how do you interpret "correct behavior" in section 4.2.1?
 "Clients MUST use filehandle comparisons only to improve performance, not for correct behavior. All clients need to be prepared for situations in which it cannot be determined whether two filehandles denote the same object and in such cases, avoid making invalid assumptions which might cause incorrect behavior."
Don't you consider data corruption due to cache inconsistency an incorrect behavior?

Benny
