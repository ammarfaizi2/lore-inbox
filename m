Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277206AbRJQVDG>; Wed, 17 Oct 2001 17:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277208AbRJQVC4>; Wed, 17 Oct 2001 17:02:56 -0400
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:26885 "EHLO
	moria.gondor.com") by vger.kernel.org with ESMTP id <S277206AbRJQVCk>;
	Wed, 17 Oct 2001 17:02:40 -0400
Date: Wed, 17 Oct 2001 23:03:13 +0200
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Oops in usb-storage.c
Message-ID: <20011017230312.A21046@gondor.com>
In-Reply-To: <20011017005822.A2161@gondor.com> <20011016175640.A18541@one-eyed-alien.net> <20011017031113.A3072@gondor.com> <20011016183243.B18541@one-eyed-alien.net> <20011017034410.A3722@gondor.com> <20011016232452.A22978@one-eyed-alien.net> <20011017124249.A1505@gondor.com> <20011017121540.A32020@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011017121540.A32020@one-eyed-alien.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2001 at 12:15:40PM -0700, Matthew Dharm wrote:
> This looks better... but you have a dangerous memset() in an else clause --
> the request buffer pointer could be pointing to a scatter-gather list, so
> you can't just memset on it.

Oh yes, I see - this memset is probably useless with the latest patch.
With an older version, it prevented the return of garbage from INQUIRY
in some cases, but with the later version INQUIRY is handeld specially
anyways.

Jan

