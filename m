Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288577AbSAICTD>; Tue, 8 Jan 2002 21:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288723AbSAICSy>; Tue, 8 Jan 2002 21:18:54 -0500
Received: from nile.gnat.com ([205.232.38.5]:25841 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S288577AbSAICSg>;
	Tue, 8 Jan 2002 21:18:36 -0500
From: dewar@gnat.com
To: dewar@gnat.com, mrs@windriver.com, paulus@samba.org
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Message-Id: <20020109021836.53D84F2FFB@nile.gnat.com>
Date: Tue,  8 Jan 2002 21:18:36 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<I noticed you failed to answer my question.  Why's that?  The answer
is, the standard is not a formal document.  If it were, you would be
able to point at the line that had the requirement that said it would
not scribble all over memory.  It is just that simple.
>>

Sorry, it *is* a formal document. Your question was with respect to Ada,
so if you are really interested here is the quote:

8   The external effect of the execution of an Ada program is defined in
terms of its interactions with its external environment.  The following are
defined as external interactions:

    9  Any interaction with an external file (see A.7);

   10  The execution of certain code_statements (see 13.8); which code_
       statements cause external interactions is implementation defined.

   11  Any call on an imported subprogram (see Annex B), including any
       parameters passed to it;

   12  Any result returned or exception propagated from a main
       subprogram (see 10.2) or an exported subprogram (see Annex B) to
       an external caller;

   13  Any read or update of an atomic or volatile object (see C.6);

   14  The values of imported and exported objects (see Annex B) at the
       time of any other interaction with the external environment.

Now the question is: does scribbling come under any of these definitions.
One would have to look at the particular definition of scribbling to know.
In particular, the compiler has to prove that such scribbling does not
violate 13 or 14. Rather hard, if you give me a specific example of a
an action performed by a scribbling compiler. I will tell you whether
it is conforming or not.

Note that the Ada standard also has the concept of implementation advice.
So one should also look there. It is not strictly normative, but in practice
has some semi-normative force.

The standard is most certainly a formal document in the legal sense. If
you are complaining that it is not mathematicaly precise, OK, but such
precision comes with other costs, so the intention of both the C and
Ada standards is that they are at an appropriate level of formality.

Of *course* it is the case that a conforming compiler that meets all the
requirements of the standards, and, in the case of Ada, also passes the
ISO approved validation suite (there is no such for C), may still be
complete junk for a given purpose (the original Ada-Ed compiler which
compiled Ada, and then executed it at the rate of about 1 statement 
per second was hardly useful for Mil-Aero applications :-)
