Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVDILCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVDILCo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 07:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVDILCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 07:02:43 -0400
Received: from f16.mail.ru ([194.67.57.46]:13326 "EHLO f16.mail.ru")
	by vger.kernel.org with ESMTP id S261332AbVDILCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 07:02:39 -0400
From: Samium Gromoff <_deepfire@mail.ru>
To: martin@dalecki.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 10.128.0.1 via proxy [80.92.100.69]
Date: Sat, 09 Apr 2005 15:02:38 +0400
Reply-To: Samium Gromoff <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1DKDja-000MGy-00._deepfire-mail-ru@f16.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, this was literally screaming for a rebuttal! :-)                                                 
                                                                                                     
> Arch isn't a sound example of software design. Quite contrary to the                               
> random notes posted by it's author the following issues did strike me                              
> the time I did evaluate it:                                                                        
(Note that here you take a stab at the Arch design fundamentals, but                                 
actually fail to substantiate it later)                                                              
                                                                                                     
> The application (tla) claims to have "intuitive" command names. However                            
> I didn't see that as given. Most of them where difficult to remember                               
> and appeared to be just infantile. I stopped looking further after I                               
> saw:                                                                                               
[ UI issues snipped, not really core design ]                                                        
                                                                                                     
Yes, some people perceive that there _are_ UI issues in Arch.                                        
However, as strange as it may sound, some don`t feel so.                                             
                                                                                                     
> As an added bonus it relies on the applications named by accident                                  
> patch and diff and installed on the host in question as well as few                                
> other as well to                                                                                   
> operate.                                                                                           
                                                                                                     
This is called modularity and code reuse.                                                            
                                                                                                     
And given that patch and diff are installed by default on all of the                                 
relevant developer machines i fail to see as to why it is by any                                     
measure a derogatory.                                                                                
                                                                                                     
(and the rest you speak about is tar and gzip)                                                       
                                                                                                     
> Better don't waste your time with looking at Arch. Stick with patches                              
> you maintain by hand combined with some scripts containing a list of                               
> apply commands                                                                                     
> and you should be still more productive then when using Arch.                                      
                                                                                                     
Sure, you should`ve had come up with something more based than that! :-)                             
                                                                                                     
Now to the real design issues...                                                                     
                                                                                                     
Globally unique, meaningful, symbolic revision names -- the core of the                              
Arch namespace.                                                                                      
                                                                                                     
"Stone simple" on-disk format to store things -- a hierarchy                                         
of directories with textual files and tarballs.                                                      
                                                                                                     
No smart server -- any sftp, ftp, webdav (or just http for read-only access)                         
server is exactly up to the task.                                                                    
                                                                                                     
O(0) branching -- a branch is simply a tag, a continuation from some                                 
point of development. A network-capable-symlink if you would like.                                   
It is actually made possible due to the global Arch namespace.                                       
                                                                                                     
Revision ancestry graph, of course. Enables smart merging.                                           
                                                                                                     
Now, to the features:                                                                                
                                                                                                     
Archives/revisions are trivially crypto-signed -- thanks to the "stone-simple"                       
on-disk format.                                                                                      
                                                                                                     
Trivial push/pull mirroring -- a mirror is exactly a read-only archive,                              
and can be turned into a full-blown archive by removal of a single                                   
file.                                                                                                
                                                                                                     
Revision libraries as client-side operation speedup mechanism with partially                         
automated updates.                                                                                   
                                                                                                     
Cached revisions as server-side speedup.                                                             

Possibility for hardlinked checkouts for local archives. This requires that                          
your text editor is smart and deletes the original file when it writes                               
changes.                                                                                             

Various pre/post/whatever-commit hooks.

That much for starters... :-)

---
cheers,
   Samium Gromoff
