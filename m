Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289598AbSA2LqB>; Tue, 29 Jan 2002 06:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289578AbSA2Lo7>; Tue, 29 Jan 2002 06:44:59 -0500
Received: from pc-80-195-34-66-ed.blueyonder.co.uk ([80.195.34.66]:23937 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S289516AbSA2Lma>; Tue, 29 Jan 2002 06:42:30 -0500
Date: Tue, 29 Jan 2002 11:42:22 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Yann E. MORIN" <yann.morin.1998@anciens.enib.fr>
Cc: lkml <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net
Subject: Re: Assertion failure / do_get_write_acess() / loop / samba
Message-ID: <20020129114222.B2298@redhat.com>
In-Reply-To: <008f01c1a815$d8cdcc70$8a140237@rennes.si.fr.atosorigin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <008f01c1a815$d8cdcc70$8a140237@rennes.si.fr.atosorigin.com>; from yann.morin.1998@anciens.enib.fr on Mon, Jan 28, 2002 at 05:07:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 28, 2002 at 05:07:12PM +0100, Yann E. MORIN wrote:
> 
> I've encountered a reproductible 'Assertion failure' in 2.4.17.
> It happens on pure vanilla, as well as on sched O1-J0, and also on

> I'm able to write a bit of data on it (about a few Mib), and then I
> got this Assertion failure:
> 
> --8<-- Begin --8<--
> Assertion failure in do_get_write_access() at transaction.c:728:
> "(((jh2bh(jh))->b_state & (1UL << BH_Uptodate)) != 0)"

Are there any other log messages in the kernel log?

The only easy way I can see for this to be triggered is if there is a
bad block on disk being accessed.  That ought to appear in the log.

Could you also please run ksymoops to decode the log trace?

Cheers,
 Stephen
