Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWCCUC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWCCUC4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 15:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWCCUC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 15:02:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58753 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932080AbWCCUCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 15:02:55 -0500
Subject: Re: Memory barriers and spin_unlock safety
From: Arjan van de Ven <arjan@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, jblunck@suse.de,
       bcrl@linux.intel.com, matthew@wil.cx, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1146.1141404346@warthog.cambridge.redhat.com>
References: <32518.1141401780@warthog.cambridge.redhat.com>
	 <1146.1141404346@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 21:02:12 +0100
Message-Id: <1141416133.10732.65.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-03 at 16:45 +0000, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
> 
> > 	WRITE mtx
> > 	--> implies SFENCE
> 
> Actually, I'm not sure this is true. The AMD64 Instruction Manual's writeup of
> SFENCE implies that writes can be reordered, which sort of contradicts what
> the AMD64 System Programming Manual says.

there are 2 or 3 special instructions which do "non temporal
stores" (movntq and movnit and maybe one more). sfense is designed for
those. 


