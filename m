Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265196AbTBKPzw>; Tue, 11 Feb 2003 10:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265532AbTBKPzw>; Tue, 11 Feb 2003 10:55:52 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:3846 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265196AbTBKPzv>; Tue, 11 Feb 2003 10:55:51 -0500
Date: Tue, 11 Feb 2003 16:05:38 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Peter Leif Rasmussen (PLR)" <PLR@tt.dk>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: A change to scsi.h
Message-ID: <20030211160538.A14675@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Peter Leif Rasmussen (PLR)" <PLR@tt.dk>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <E8F83D6D2A6AD3118E0300902786A2050249961F@ntex.tt.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E8F83D6D2A6AD3118E0300902786A2050249961F@ntex.tt.dk>; from PLR@tt.dk on Tue, Feb 11, 2003 at 04:54:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2003 at 04:54:16PM +0100, Peter Leif Rasmussen (PLR) wrote:
> When looking into:
> 
> /usr/src/linux/include/scsi/scsi.h
> 
> in kernel revision 2.5.60 I find this in line 200 - 205:
> 
> /*
>  * ScsiLun: 8 byte LUN.
>  */
> typedef struct scsi_lun {
>         u8 scsi_lun[8];
> } ScsiLun;
> 
> This produces problems when compiling a package that doesn't know about
> 'u8'.

Userland code is not supposed to include kernel headers.

