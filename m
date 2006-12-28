Return-Path: <linux-kernel-owner+w=401wt.eu-S1754914AbWL1SxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914AbWL1SxT (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 13:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754925AbWL1SxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 13:53:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48483 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911AbWL1SxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 13:53:18 -0500
Subject: Re: Want comments regarding patch
From: Arjan van de Ven <arjan@infradead.org>
To: Daniel =?ISO-8859-1?Q?Marjam=E4ki?= <daniel.marjamaki@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <80ec54e90612281041q3b2c2bcemb0308c1e89a29ac@mail.gmail.com>
References: <80ec54e90612281041q3b2c2bcemb0308c1e89a29ac@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Organization: Intel International BV
Date: Thu, 28 Dec 2006 19:53:15 +0100
Message-Id: <1167331995.3281.4374.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-28 at 19:41 +0100, Daniel Marjamäki wrote:
> Hello all!
> 
> I sent a patch with this content:
> 
> -       for (i = 0; i < MAX_PIRQS; i++)
> -               pirq_entries[i] = -1;
> +       memset(pirq_entries, -1, sizeof(pirq_entries));
> 
> I'd like to know if you have any comments to this change. It was of
> course my intention to make the code shorter, simpler and faster.

Hi,

personally I don't like the new code; memset only takes a byte as
argument and while it probably is the same, that is now implicit
behavior and no longer explicit. A reasonably good compiler will notice
it's the same and generate the best code anyway, so I would really
really suggest to go for the best readable code, which imo is the
original code.

Greetings,
   Arjan van de Ven


