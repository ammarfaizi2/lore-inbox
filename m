Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbWHONi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbWHONi5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 09:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbWHONi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 09:38:57 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:41134 "EHLO
	ms-smtp-01.texas.rr.com") by vger.kernel.org with ESMTP
	id S1030289AbWHONi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 09:38:56 -0400
Message-ID: <44E1CE95.304@austin.rr.com>
Date: Tue, 15 Aug 2006 08:39:33 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] endianness bitrot in cifs
References: <20060815091646.GX29920@ftp.linux.org.uk>
In-Reply-To: <20060815091646.GX29920@ftp.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> 	le16 compared to host-endian constant
> 	u8 fed to le32_to_cpu()
> 	le16 compared to host-endian constant
>   

Thanks - I have applied this to the cifs git tree so should be in mm soon.
Fortunately this only hit the relatively new lanman support (e.g. Win9x 
and OS/2 server support not as common anymore - but was needed before 
smbfs deprecation).
