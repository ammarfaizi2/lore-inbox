Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277404AbRJOLZr>; Mon, 15 Oct 2001 07:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277401AbRJOLZh>; Mon, 15 Oct 2001 07:25:37 -0400
Received: from pcephc56.cern.ch ([137.138.38.92]:35968 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S277395AbRJOLZd>; Mon, 15 Oct 2001 07:25:33 -0400
Date: Mon, 15 Oct 2001 13:24:59 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
Message-ID: <20011015132459.A4269@kushida.jlokier.co.uk>
In-Reply-To: <20011013205445.A24854@kushida.jlokier.co.uk> <Pine.LNX.4.33.0110131219520.8900-100000@penguin.transmeta.com> <20011013214603.A1144@kushida.jlokier.co.uk> <20011013144337.D9856@vitelus.com> <m1r8s7qior.fsf@frodo.biederman.org> <20011013155005.E9856@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011013155005.E9856@vitelus.com>; from aaronl@vitelus.com on Sat, Oct 13, 2001 at 03:50:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann wrote:
> > > But it does have the advantage of allowing the sharing of memory, does
> > > it not?
> > 
> > Only if you are going to write to the data.
> 
> Why? If gcc and another application read the source file with an
> mmap() with the right parameters (read-only), it would only be shared
> between them, as I understand it. If they both read() the file into
> private buffers those can not be shared.

And furthermore, the private buffers cannot be shared with the
filesystem's page cache.

-- Jamie

