Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290356AbSAPFAB>; Wed, 16 Jan 2002 00:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290357AbSAPE7x>; Tue, 15 Jan 2002 23:59:53 -0500
Received: from windlord.Stanford.EDU ([171.64.13.23]:38070 "HELO
	windlord.stanford.edu") by vger.kernel.org with SMTP
	id <S290356AbSAPE7j>; Tue, 15 Jan 2002 23:59:39 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.3-pre1 compile error
In-Reply-To: <fa.oa9ld7v.gk65b0@ifi.uio.no> <fa.g97h3fv.968725@ifi.uio.no>
In-Reply-To: <fa.g97h3fv.968725@ifi.uio.no> (dmeyer@dmeyer.net's message of
 "Wed, 16 Jan 2002 02:11:58 GMT")
From: Russ Allbery <rra@stanford.edu>
Organization: The Eyrie
Date: Tue, 15 Jan 2002 20:59:32 -0800
Message-ID: <ylu1tm99hn.fsf@windlord.stanford.edu>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Common Lisp,
 sparc-sun-solaris2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dmeyer <dmeyer@dmeyer.net> writes:
> In article <20020116015513.L32088@suse.de> you write:

>>  I'm sure I read somewhere that gcc is clever enough to know when it
>>  hits a #include, it checks for a symbol equal to a mangled version of
>>  the filename before including it.  (Ie, doing this transparently).

>>  Then again, I may have imagined it all.

No, you read that gcc notices when the entirety of a source file is
wrapped in an #ifdef guard and won't re-read that file when it's included
again if the symbol is defined.

> In answer to Linus' question...yes, in a large system redundent include
> guards can make a real difference, particularly for headers which get
> included by other headers regularly.

Yes, but you don't need to put them around the #include.  Just make sure
there is nothing but comments outside the multiple inclusion guards in the
header files and any competent compiler will do the right thing.

-- 
Russ Allbery (rra@stanford.edu)             <http://www.eyrie.org/~eagle/>
