Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314676AbSEUOmC>; Tue, 21 May 2002 10:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314659AbSEUOmB>; Tue, 21 May 2002 10:42:01 -0400
Received: from gherkin.frus.com ([192.158.254.49]:35969 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S314676AbSEUOmA>;
	Tue, 21 May 2002 10:42:00 -0400
Message-Id: <m17AApp-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: 2.5.X: intermezzo compile errors
To: linux-kernel@vger.kernel.org
Date: Tue, 21 May 2002 09:41:57 -0500 (CDT)
CC: braam@clusterfs.com
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are people actually using the intermezzo fs with recent 2.5.X kernels?
The compile has been broken for quite some time due to the following:

(1) linux/include/linux/intermezzo_psdev.h: ISLENTO() define references
    a "p_pptr" structure member that has been replaced by "parent".

(2) In the 2.5.5 timeframe, the "i_zombie" member of "struct inode"
    went away, and most of the filesystem code was modified accordingly.
    The intermezzo fs never got "the treatment" as far as I can tell.
    Affected source files are linux/fs/intermezzo/vfs.c and dir.c.

(3) linux/fs/intermezzo/super.c: no "read_super" structure member.

(4) linux/fs/intermezzo/psdev.c: syntax error (missing brace) causes
    numerous compilation errors.  After adding the missing brace,
    there's still a problem with the third arg of lento_mknod() at
    line 773.

If there's an intermezzo patch set somewhere, I'm sure someone will
point me to it :-).

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
