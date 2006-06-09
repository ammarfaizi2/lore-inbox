Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965074AbWFIBN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbWFIBN5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 21:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbWFIBN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 21:13:57 -0400
Received: from science.horizon.com ([192.35.100.1]:10539 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S965076AbWFIBN5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 21:13:57 -0400
Date: 8 Jun 2006 21:13:55 -0400
Message-ID: <20060609011355.17217.qmail@science.horizon.com>
From: linux@horizon.com
To: jfritschi@freenet.de, linux@horizon.com
Subject: Re: [PATCH  4/4] Twofish cipher - x86_64 assembler
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200606081935.14649.jfritschi@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You can't use the 8bit high register with rex prefix registers ( r8+
> and any 64bit register). I guess this could be fixed be moving the crypto
> ctx or the output adress to a rex register and have %esi or %edi as temp
> register for the sbox-index. Somehow i never considered %esi or %edi as
> a possible target for the 8bit high operation and was convinced the only
> way to avoid using 4 * 8bit rotates was using temporary registers.

Oh, yeah!  Sorry about that.  You're quite right, but you're also
quite right that it's fixable.

I'd have to refresh my memory of the whole REX prefix business to figure
out how to minimize the code size.  I've forgotten the details.


Anyway, I'm glad to have been of some help.
