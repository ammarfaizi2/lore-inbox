Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293721AbSCUJo1>; Thu, 21 Mar 2002 04:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293722AbSCUJoR>; Thu, 21 Mar 2002 04:44:17 -0500
Received: from fungus.teststation.com ([212.32.186.211]:3849 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S293721AbSCUJoC>; Thu, 21 Mar 2002 04:44:02 -0500
Date: Thu, 21 Mar 2002 10:43:59 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.teststation.com
To: david@shepard.tc
cc: linux-kernel@vger.kernel.org
Subject: Re: smbfs font corruption in 2.5.7
In-Reply-To: <20020320233806.684.qmail@www4.nameplanet.com>
Message-ID: <Pine.LNX.4.44.0203211015540.5781-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Mar 2002 david@shepard.tc wrote:

> It appears there were some changes made during 2.5.6 to allow for smbfs
> unicode support. The problem appears any time I mount an smb filesystem,
> whether in X or at VGA framebuffer console. File and directory names
> show up in a language I don't speak. Is there some setting I should

The idea was not to change the default settings. You won't get any unicode
stuff unless you patch samba and also send smbmount some special options.
(and even then the unicode bits are "on-the-wire", not in the output you
see).

Could you perhaps send the output of 'grep NLS .config' ?
And the smbfs lines from 'cat /proc/mounts'?

If the strange characters are 2 chars where there should be only one, you
have probably configured it to use utf8 but your console/X is set for
something else.

If the chars look like ':xa6' or ':00a6' then it is a nls translation
error and you should examine what codepage/iocharset settings you use.

/Urban

