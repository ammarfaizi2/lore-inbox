Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129258AbRBTBJy>; Mon, 19 Feb 2001 20:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129268AbRBTBJn>; Mon, 19 Feb 2001 20:09:43 -0500
Received: from laurin.munich.netsurf.de ([194.64.166.1]:41420 "EHLO
	laurin.munich.netsurf.de") by vger.kernel.org with ESMTP
	id <S129258AbRBTBJf>; Mon, 19 Feb 2001 20:09:35 -0500
Date: Tue, 20 Feb 2001 02:10:12 +0100
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is this the ultimate stack-smash fix?
Message-ID: <20010220021012.A1481@storm.local>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3A899FEB.D54ABBC7@sympatico.ca> <m1lmr98c5t.fsf@frodo.biederman.org> <3A8ADA30.2936D3B1@sympatico.ca> <m1hf1w8qea.fsf@frodo.biederman.org> <3A8BF5ED.1C12435A@colorfullife.com> <m1k86s6imn.fsf@frodo.biederman.org> <20010217084330.A17398@cadcamlab.org> <m1y9v4382r.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m1y9v4382r.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sat, Feb 17, 2001 at 09:53:48PM -0700
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2001 at 09:53:48PM -0700, Eric W. Biederman wrote:
> Peter Samuelson <peter@cadcamlab.org> writes:
> > It also sounds like you will be
> > breaking the extremely useful C postulate that, at the ABI level at
> > least, arrays and pointers are equivalent.  I can't see *how* you plan
> > to work around that one.
> 
> Huh?  Pointers and arrays are clearly different at the ABI level.
> 
> A pointer is a word that contains an address of something.
> An array is an array.

An array is a word that contains the address of the first element.

Exercise 1:  What is the difference between the following two
declarations at the source level and at the ABI level?

a) int main(int argc, char *argv[])
b) int main(int argc, char **argv)


Exercise 2:  What would the following in hypothetical C startup code do?

	char *args[10];
	int count = 10;

	...

	exit(main(count - 1, args + 1));

-- 
 Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
http://home.pages.de/~andreas.bombe/    http://linux1394.sourceforge.net/
