Return-Path: <linux-kernel-owner+w=401wt.eu-S964971AbWLTMM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWLTMM0 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 07:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754807AbWLTMMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 07:12:25 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:44913 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806AbWLTMMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 07:12:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Sz1XsHA3T+L4LGC8rf6/Q+3pCnvnGNCi5lI8cZDCAaY8IGvUqhVNZw+j3nadKfhTYKa6LyGm9RUh48ZJbyMkCloY8Lk0pdaru8ZlUNPAqGw/J2vUP3OArQBjsX4qrGd/2m/+c970o+DBAvIfmM8v1BCx0Z86yKqnPzrnDiC1eck=
Message-ID: <9a8748490612200412j34d90afah786bff071f34110b@mail.gmail.com>
Date: Wed, 20 Dec 2006 13:12:24 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Andrei Popa" <andrei.popa@i-neo.ro>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Hugh Dickins" <hugh@veritas.com>, "Florian Weimer" <fw@deneb.enyo.de>,
       "Marc Haber" <mh+linux-kernel@zugschlus.de>,
       "Martin Michlmayr" <tbm@cyrius.com>,
       "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
       "Heiko Carstens" <heiko.carstens@de.ibm.com>,
       "Arnd Bergmann" <arnd.bergmann@de.ibm.com>
In-Reply-To: <1166614939.10372.208.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1166314399.7018.6.camel@localhost>
	 <1166471069.6940.4.camel@localhost>
	 <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	 <1166571749.10372.178.camel@twins>
	 <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
	 <1166605296.10372.191.camel@twins>
	 <1166607554.3365.1354.camel@laptopd505.fenrus.org>
	 <1166614001.10372.205.camel@twins>
	 <9a8748490612200339x4b50f0e1i3da4313bea85fbc6@mail.gmail.com>
	 <1166614939.10372.208.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/06, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> On Wed, 2006-12-20 at 12:39 +0100, Jesper Juhl wrote:
> > Having the assignment of "ret = 1;" inside the loop seems a little
> > pointless. Perhaps gcc can optimize it, but still, that assignment
> > really only needs to happen once outside the loop.
>
> Sure, but I was hoping gcc was smart enough. Placing it outside the loop
> would require an extra if stmt. Also the chance this loop will actually
> be traversed more than once is _very_ small.
>

allright - I just spotted it and thought I'd point it out :-)

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
