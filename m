Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264274AbTKZRTd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 12:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbTKZRTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 12:19:33 -0500
Received: from holomorphy.com ([199.26.172.102]:63677 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264274AbTKZRTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 12:19:31 -0500
Date: Wed, 26 Nov 2003 09:19:25 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: amanda vs 2.6
Message-ID: <20031126171925.GR8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org
References: <200311261212.10166.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311261212.10166.gene.heskett@verizon.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 26, 2003 at 12:12:10PM -0500, Gene Heskett wrote:
> Greetings everybody, scsi folks in particular;
> I don't know if I've got a bad, miss-set link thats effecting the 
> build of amanda, or ???
> Preconditions:
> tape drive has magazine, magazine ejected and reloaded, but all tapes 
> still reside in the magazine carrier.
> Under a 2.4.22-pre10 boot, a run of amcheck will load the last loaded 
> slot of the magazine and proceed to search the magazine for the next, 
> correct tape.
> Under a 2.6.0test9 or 10 boot, it loads a tape, but then gets a signal 
> 11 and exits.  A re-run from that point, where it does have a loaded 
> tape from the first run, proceeds 100% normally in searching the 
> magazine.
> Preset the magazine again and run it with gdb, and get this only if 
> booted to a 2.6 kernel:

Please retry with:
echo 1 > /proc/sys/vm/overcommit_memory


-- wli
