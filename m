Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278431AbRJMWuA>; Sat, 13 Oct 2001 18:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278432AbRJMWtu>; Sat, 13 Oct 2001 18:49:50 -0400
Received: from vitelus.com ([64.81.243.207]:18951 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S278431AbRJMWtg>;
	Sat, 13 Oct 2001 18:49:36 -0400
Date: Sat, 13 Oct 2001 15:50:05 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
Message-ID: <20011013155005.E9856@vitelus.com>
In-Reply-To: <20011013205445.A24854@kushida.jlokier.co.uk> <Pine.LNX.4.33.0110131219520.8900-100000@penguin.transmeta.com> <20011013214603.A1144@kushida.jlokier.co.uk> <20011013144337.D9856@vitelus.com> <m1r8s7qior.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1r8s7qior.fsf@frodo.biederman.org>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2001 at 04:27:48PM -0600, Eric W. Biederman wrote:
> > But it does have the advantage of allowing the sharing of memory, does
> > it not?
> 
> Only if you are going to write to the data.

Why? If gcc and another application read the source file with an
mmap() with the right parameters (read-only), it would only be shared
between them, as I understand it. If they both read() the file into
private buffers those can not be shared.
