Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265180AbRFUUCb>; Thu, 21 Jun 2001 16:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265188AbRFUUCV>; Thu, 21 Jun 2001 16:02:21 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:39185 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S265180AbRFUUCE> convert rfc822-to-8bit; Thu, 21 Jun 2001 16:02:04 -0400
X-Apparently-From: <xioborg@yahoo.com>
From: Steve Brueggeman <xioborg@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Controversy over dynamic linking -- how to end the panic
Date: Thu, 21 Jun 2001 15:02:01 -0500
Message-ID: <ncj4jt47r6l4avihaoj1248l1tofopnqt8@4ax.com>
In-Reply-To: <200106211814.f5LIEgK04880@snark.thyrsus.com> <3B323F51.BEDC7712@resilience.com>
In-Reply-To: <3B323F51.BEDC7712@resilience.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your analogy is flawed.
You state that "the kernel is the equivalent of an application", when
compared to user-space application/library relationships.

The flaw in this analogy is, a library does 'require! and use'
routines provided by the application.  The library provides methods
and services TO the application through a well defined API.  This is
exactly what the kernel also provides.

So, IMHO, the kernel is also acting more like a library, and drivers
are wrappers around that library, much the same as libc gets wrapped
by many other libraries to provide higher-level services.

If your analogy were accurate, there would be no issue here.  The
driver (library in your analogy) would become simply a provider, to be
used by others, and as such, the driver's license would be effecting
the users of the API (kernel/application in your analogy).

I believe the licensing issue here is more related to the fact that,
for a driver to be useful, it must use the services of the kernel.
The problem is complicated by the fact, that unlike sys_call()'s, the
API that drivers use, cannot by nature, be very well defined.  

If you are to allow proprietary, binary only drivers, you must then
come up with some generalized definition.

Personally, I'd rather like to see some standardized, well defined,
stable  kernel provider API,to which  binary-only drivers could design
to, and know they're legally safe.  This has been discussed before,
and, NO, I am definitely not trying to rekindle that flame-war.  I
just think that it would both make a legal stand on this issue
stronger, and it would also give those who want to provide binary-only
code the ability to do so with some confidence.

Just my $0.02 worth.
(me thinks that by the time this thread ends, he who collects all of
the 2-cents dropped here, will be rich)

(If I had 2-cents for every time......)



On Thu, 21 Jun 2001 11:39:13 -0700, you wrote:

>"Eric S. Raymond" wrote:
>> ------------------------------------------------------------------------
[snip]
>> 
>> 2. A driver or other kernel component which is statically linked to
>>    the kernel *is* to be considered a derivative work.
[snip[
>
>I disagree with 2.  Consider the following:
>
>- GPL library foo is used by application bar.  bar must be GPL because
>foo is.  I agree with this.
>- Non-GPL library foo is used by GPL application bar.  foo does NOT
>become GPL just because bar is, even if bar statically linked foo in.
>
>The kernel is the equivalent of an application.  If someone needs to
>statically link in a driver, which is the equivalent of a library, I
>don't see how that should make the driver GPL.
>
>
>-Jeff
>
>P.S.  I don't claim to be a lawyer, this is just my opinion.


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

