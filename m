Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbTLLVhp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 16:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbTLLVhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 16:37:45 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:39398 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id S262052AbTLLVhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 16:37:32 -0500
From: Daniel Phillips <phillips@arcor.de>
To: Andreas Dilger <adilger@clusterfs.com>, Hua Zhong <hzhong@cisco.com>
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Date: Fri, 12 Dec 2003 16:37:17 -0500
User-Agent: KMail/1.5.4
Cc: "'Andy Isaacson'" <adi@hexapodia.org>, linux-kernel@vger.kernel.org
References: <20031211125806.B2422@hexapodia.org> <017c01c3c01b$232bd130$d43147ab@amer.cisco.com> <20031211124312.E27396@schatzie.adilger.int>
In-Reply-To: <20031211124312.E27396@schatzie.adilger.int>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200312121635.52537.phillips@arcor.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Thursday 11 December 2003 14:43, Andreas Dilger wrote:
> Presumably, if a filesystem didn't support a punch filesystem method
> (either because it is unimplemented or because the filesystem doesn't
> support holes) it would be implemented as either a truncate (if end is
> beyond i_size) or a series of zero writes instead.

It would be more regular and less surprising to make it semantically 
equivalent to writing a string of zeros, that is, it will never truncate and 
may extend a file.

Regards,

Daniel

