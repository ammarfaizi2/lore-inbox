Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316408AbSGYVG6>; Thu, 25 Jul 2002 17:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316437AbSGYVG6>; Thu, 25 Jul 2002 17:06:58 -0400
Received: from relay1.pair.com ([209.68.1.20]:31754 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S316408AbSGYVG5>;
	Thu, 25 Jul 2002 17:06:57 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3D406A09.37CE334@kegel.com>
Date: Thu, 25 Jul 2002 14:13:45 -0700
From: dank@kegel.com
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Header files and the kernel ABI
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron <oxymoron@waste.org> wrote:
> 
> On Thu, 25 Jul 2002, Erik Andersen wrote:
> 
> > On Thu Jul 25, 2002 at 09:31:23AM -0700, H. Peter Anvin wrote:
> > > Oliver Xymoron wrote:
> > > >
> > > >Ideally, the ABI layer would be maintained and packaged separately from
> > > >both the kernel and glibc to avoid gratuitous changes from either side.
> > >
> > > I disagree.  The ABI is a product of the kernel and should be attached
> > > to it.  It is *not* a product of glibc -- glibc is a consumer of it, as
> > > are any other libcs.
> >
> > Agreed.  I maintain a libc and I certainly do not want to
> > have to maintain the kernel ABI of the day headers.  That
> > is clearly a job for the kernel.
> 
> The idea of maintaining them separately is that people won't be able to
> touch the ABI without explicitly going through a gatekeeper whose job is
> to minimize breakage. Linus usually catches ABI changes but not always.
> 
> I explicitly did _not_ suggest making it the job of libc maintainers. And
> the whole point of the exercise is to avoid ABI of the day anyway. The ABI
> should change less frequently than the kernel or libc. It's more analogous
> to something like modutils.

IMHO it should live with the kernel, at least for now.  
The ABI .h files can live in a walled-off area that stays as stable as possible.
Anyone building glibc should be able to grab the ABI .h files from a
recent linux kernel source tarball without much effort.  (Maybe we'd
add a 'install headers_install' make target to install the ABI .h files
to make it obvious how to get them.)

Imagine what would happen if the base ABI .h files were maintained 
as part of a future Linux Standard Base, with the kernel only maintaining
.h files for extensions to the base ABI.  You'd need to install the ABI .h 
files before you could build the kernel!  That might be the right way to
go, but let's not propose it until the ABI .h files exist and are useful.

- Dan
