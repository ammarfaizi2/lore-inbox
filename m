Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287947AbSAMCRo>; Sat, 12 Jan 2002 21:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287948AbSAMCRd>; Sat, 12 Jan 2002 21:17:33 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40976 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287947AbSAMCRO>; Sat, 12 Jan 2002 21:17:14 -0500
Message-ID: <3C40EE23.6010906@zytor.com>
Date: Sat, 12 Jan 2002 18:17:07 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: initramfs buffer spec -- second draft
In-Reply-To: <Pine.GSO.4.21.0201122045540.24774-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:

>> 
> +				or "00000000" if it's 070701.  Kernel
> +				is not expected to verify it in any case.
>  


Check.


>  
> - The c_filesize should be zero for any non-regular file.
> + The c_filesize can be non-zero only for regular files and symlinks.
> + For symlinks data and c_filesize match the results of readlink(2).
> + Having more than one link to a symlink is illegal.
> 

Why can't you have more than one link to a symlink?

	-hpa

