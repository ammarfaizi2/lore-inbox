Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132841AbRC2Svf>; Thu, 29 Mar 2001 13:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132845AbRC2SvZ>; Thu, 29 Mar 2001 13:51:25 -0500
Received: from pobox.sibyte.com ([208.12.96.20]:36363 "HELO pobox.sibyte.com")
	by vger.kernel.org with SMTP id <S132841AbRC2SvM>;
	Thu, 29 Mar 2001 13:51:12 -0500
From: Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To: Xavier Ordoquy <xordoquy@aurora-linux.com>, linux-kernel@vger.kernel.org
Subject: Re: Bug in the file attributes ?
Date: Thu, 29 Mar 2001 10:51:18 -0800
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.21.0103292011480.20805-100000@ilaws.aurora-linux.net>
In-Reply-To: <Pine.LNX.4.21.0103292011480.20805-100000@ilaws.aurora-linux.net>
MIME-Version: 1.0
Message-Id: <0103291053110G.04063@plugh.sibyte.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2001, Xavier Ordoquy wrote:
> Hi,
> 
> I just made a manipulation that disturbs me. So I'm asking whether it's a
> bug or a features.
> 
> user> su
> root> echo "test" > test
> root> ls -l
> -rw-r--r--   1 root     root            5 Mar 29 19:14 test
> root> exit
> user> rm test
> rm: remove write-protected file `test'? y
> user> ls test
> ls: test: No such file or directory
> 
> This is in the user home directory.
> Since the file is read only for the user, it should not be able to remove
> it. Moreover, the user can't write to test.
> So I think this is a bug.

You don't need write perms on a file to remove it, you need write perms on the
directory.  If you've got write permissions on the directory, you can remove
any file in the directory, regardless of the permissions.

-Justin
