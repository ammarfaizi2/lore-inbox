Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129814AbRB0UNW>; Tue, 27 Feb 2001 15:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129819AbRB0UNE>; Tue, 27 Feb 2001 15:13:04 -0500
Received: from fdsl76.dnvr.uswest.net ([209.180.253.77]:64521 "EHLO
	willie.n0ano.com") by vger.kernel.org with ESMTP id <S129814AbRB0UMx>;
	Tue, 27 Feb 2001 15:12:53 -0500
Date: Tue, 27 Feb 2001 12:59:48 -0700
From: Don Dugger <ddugger@willie.n0ano.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: binfmt_script and ^M
Message-ID: <20010227125948.A26290@willie.n0ano.com>
In-Reply-To: <27525795B28BD311B28D00500481B7601F0F2D@ftrs1.intranet.ftr.nl> <20010227143823.A25058@cistron.nl> <20010227202059.C11060@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <20010227202059.C11060@pcep-jamie.cern.ch>; from Jamie Lokier on Tue, Feb 27, 2001 at 08:20:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Isn't `perl' overkill?  Why not just:

	tr -d '\r'

On Tue, Feb 27, 2001 at 08:20:59PM +0100, Jamie Lokier wrote:
> Ivo Timmermans wrote:
> > > _should_ it work with the \r in it?
> > 
> > IMHO, yes.  This set of files were created on Windows, then zipped and
> > uploaded to a Linux server, unpacked.  This does not change the \r.
> 
> Use `fromdos' to convert the files.  Or this little Perl gem, which
> takes a list of files or standard input as argument:
> 
> #!/usr/bin/perl -pi
> s/\r\n$/\n/
> 
> -- Jamie
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Don Dugger
"Censeo Toto nos in Kansa esse decisse." - D. Gale
n0ano@valinux.com
Ph: 303/938-9838
