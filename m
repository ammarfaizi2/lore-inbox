Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSHIViy>; Fri, 9 Aug 2002 17:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316088AbSHIViy>; Fri, 9 Aug 2002 17:38:54 -0400
Received: from hercules.egenera.com ([208.254.46.135]:10 "HELO
	coyote.egenera.com") by vger.kernel.org with SMTP
	id <S316070AbSHIVix>; Fri, 9 Aug 2002 17:38:53 -0400
Date: Fri, 9 Aug 2002 17:42:32 -0400
From: Phil Auld <pauld@egenera.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: why is lseek broken (>= 2.4.11) ?
Message-ID: <20020809174232.Z3542@vienna.EGENERA.COM>
References: <20020809084915.P3542@vienna.EGENERA.COM> <3D542AAE.64B70B55@zip.com.au> <20020809211306.GA1252@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020809211306.GA1252@win.tue.nl>; from aebr@win.tue.nl on Fri, Aug 09, 2002 at 11:13:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rumor has it that on Fri, Aug 09, 2002 at 11:13:06PM +0200 Andries Brouwer said:
> On Fri, Aug 09, 2002 at 01:48:47PM -0700, Andrew Morton wrote:
> 
> > What should the behaviour be?   The lseek should succeed,
> 
> Yes
> 
> > but subsequent reads and writes return zero?
> 
> Yes. The first read must return 0. Subsequent reads may return 0
> or return the ENXIO error.
> 
> For read: "No data transfer shall occur past the current end-of-file.
> If the starting position is at or after the end-of-file, 0 shall be
> returned. If the file refers to a device special file, the result of
> subsequent read() requests is implementation-defined."
> 
> ENXIO: "the request was outside the capabilities of the device".
> 
> For write: "If a write() requests that more bytes be written than
> there is room for (for example, ... the physical end of a medium),
> only as many bytes as there is room for shall be written.
> 

Agreed. That is what the standards say... And what userspace has come to expect.


Phil


> 
> Andries
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Philip R. Auld, Ph.D.                  Technical Staff 
Egenera Corp.                        pauld@egenera.com
165 Forest St., Marlboro, MA 01752       (508)858-2600
