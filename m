Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbTJNFcB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 01:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbTJNFcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 01:32:01 -0400
Received: from web13004.mail.yahoo.com ([216.136.174.14]:39806 "HELO
	web13004.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262186AbTJNFbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 01:31:55 -0400
Message-ID: <20031014053155.31639.qmail@web13004.mail.yahoo.com>
Date: Mon, 13 Oct 2003 22:31:55 -0700 (PDT)
From: retu <retu834@yahoo.com>
Subject: Re: 2.7 thoughts: common well-architected object model
To: James Antill <james@and.org>
Cc: m.fioretti@inwind.it, linux-kernel@vger.kernel.org
In-Reply-To: <m31xtg3n3a.fsf@code.and.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

// these ungeneric interfaces will kill. Right now
it's a {/usr/local/,/usr/bin/,/usr/..}
NameYourClassLibrary_empty. Below a list pasted from
the .net namespace with many dozens of classes
covering everything from io to drawing. 

They _appear for the most part to be consistent
wrappers to underlying existing APIs (including some
for >kernelspace< to userspace), are quite well done
although a little on the heavy side. I've not seen
Nextstep for years but this was a very good design
along the same lines and much thinner (implemented to
fly on 20MHz+ 68040s).

Hence, what would be needed is in the first place a
component model (well architected - thin - efficient)
that would allow folks to populate the other areas
successively. Replicating .net for licensing and
efficiency reasons (Linux ought to scale to HPC
levels), broadening some application class library OR
architecting something without the kernel in mind is
not it I believe. It's gotta come from the core, have
the ingenuity that leads others to build on it and not
start with a disconnect (to the kernelspace that is). 

If there are multiple sets of classes for e.g. 2D
drawing then so what as long as they use the same
Linux component model (which has yet to be defined or
even a grain of consens found that it is necessary in
the first place). 
 
Now here's the competition:

System 
System.CodeDom 
System.CodeDom.Compiler 
System.Collections 
System.Collections.Specialized 
System.ComponentModel 
System.ComponentModel.Design 
System.ComponentModel.Design.Serialization 
System.Configuration 
System.Configuration.Assemblies 
System.Configuration.Install 
System.Data 
System.Data.Common 
System.Data.Odbc 
System.Data.OleDb 
System.Data.OracleClient 
System.Data.SqlClient 
System.Data.SqlServerCE 
System.Data.SqlTypes 
System.Diagnostics 
System.Diagnostics.SymbolStore 
System.DirectoryServices 
System.Drawing 
System.Drawing.Drawing2D, System.Drawing.Imaging, and
System.Drawing.Text namespaces. 
System.Drawing.Design 
System.Drawing.Drawing2D 
System.Drawing.Imaging 
System.Drawing.Printing 
System.EnterpriseServices
System.Globalization 
System.IO 
System.IO.IsolatedStorage 
System.Management 
System.Net 
System.Net.Sockets 
System.Reflection 
System.Resources 
System.Runtime.CompilerServices 
System.Runtime.InteropServices 
System.Runtime.InteropServices.CustomMarshalers 
System.Runtime.InteropServices.Expando 
System.Runtime.Remoting 
System.Runtime.Remoting.Activation 
System.Runtime.Remoting.Channels 
System.Runtime.Remoting.Channels.Http 
System.Runtime.Remoting.Channels.Tcp 
System.Runtime.Remoting.Contexts 
System.Runtime.Remoting.Lifetime 
System.Runtime.Remoting.Messaging 
System.Runtime.Remoting.Metadata 
System.Runtime.Remoting.Metadata.W3cXsd2001 
System.Runtime.Remoting.MetadataServices 
System.Runtime.Remoting.Proxies 
System.Runtime.Remoting.Services 
System.Runtime.Serialization 
System.Runtime.Serialization.Formatters 
System.Runtime.Serialization.Formatters.Binary 
System.Runtime.Serialization.Formatters.Soap 
System.Security 
System.Security.Cryptography 
System.Security.Cryptography.X509Certificates 
System.Security.Cryptography.Xml 
System.Security.Permissions 
System.Security.Policy 
System.Security.Principal 
System.ServiceProcess 
System.Text 
System.Text.RegularExpressions 
System.Threading 
System.Timers 
System.Web 
System.Web.Caching 
System.Web.Hosting 
System.Web.Mail 
System.Web.Mobile 
System.Web.Security 
System.Web.Services 
System.Web.Services.Configuration 
System.Web.Services.Description 
System.Web.Services.Discovery 
System.Web.Services.Protocols 
System.Web.SessionState 
System.Web.UI 
System.Web.UI.Design 
System.Web.UI.Design.WebControls 
System.Web.UI.HtmlControls 
System.Web.UI.MobileControls 
System.Web.UI.MobileControls.Adapters 
System.Web.UI.WebControls 
System.Windows.Forms 
System.Windows.Forms.Design 
System.Xml 
System.Xml.Schema 
System.Xml.Serialization 
System.Xml.XPath 
System.Xml.Xsl 

These are massive and can't be built in a day. But
with a very decent component model and design
philosphy on what to put in and what not it would
enable people to quickly fill in the blanks (plus
maybe some rapid abstracting/wrapping) which would do
a very lot for the OS.  


--- James Antill <james@and.org> wrote:
> asdfd esadd <retu834@yahoo.com> writes:
> 
> > There is a connex, fork() might be a bad example,
> > 
> > it's simple - yes but 20 years have passed as
> Solaris
> > is finding:
> > 
> > pid_t fork(void); vs. 
> > 
> > the next step in the evolution CreateProcess
> > 
> > BOOL CreateProcess(...)
> 
>  If you _really_ want this on Linux, then you can
> look in
> /usr/include/spawn.h
> 
>  Of course, as with all of these ungeneric
> interfaces, it should
> really be called spawn-of-satan.h
> 
> -- 
> # James Antill -- james@and.org
> :0:
> * ^From: .*james@and\.org
> /dev/null



__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
